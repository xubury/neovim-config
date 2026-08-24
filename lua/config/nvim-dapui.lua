local dap = require("dap")
local dapui = require("dapui")

dapui.setup({
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "dd",
        edit = "i",
        repl = "r",
        toggle = "t",
    },
    -- Expand lines larger than the window
    -- Requires >= 0.7
    expand_lines = vim.fn.has("nvim-0.7"),
    -- Layouts define sections of the screen to place windows.
    -- The position can be "left", "right", "top" or "bottom".
    -- The size specifies the height/width depending on position. It can be an Int
    -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
    -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
    -- Elements are the elements shown in the layout (in order).
    -- Layouts are opened in order so that earlier layouts take priority in window sizing.
    layouts = {
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                "stacks",
                "breakpoints",
                "watches",
                "scopes",
            },
            size = 0.2,
            position = "left",
        },
        {
            elements = {
                -- "repl",
                "console",
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
        },
    },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil, -- Can be integer or nil.
    },
})

local keymap_restore = {}
local cleaned = true

local function cleanup()
    if cleaned then
        return
    end
    cleaned = true

    -- 恢复被 dap 覆盖的 K 键位
    for _, keymap in pairs(keymap_restore) do
        pcall(
            vim.keymap.set,
            keymap.mode,
            keymap.lhs,
            keymap.rhs or keymap.callback,
            { buffer = keymap.buffer, silent = keymap.silent == 1 }
        )
    end
    keymap_restore = {}

    pcall(function()
        vim.cmd("silent! update")
    end)
    pcall(function()
        dap.repl.close()
    end)
    pcall(function()
        dapui.close()
    end)
end

local function on_end()
    vim.schedule(cleanup)
end

dap.listeners.after.event_initialized["dapui_config"] = function(session)
    -- 新会话开始，重置清理标志与键位记录
    cleaned = false
    keymap_restore = {}

    dapui.open()

    -- 捕获并覆盖 K 键位为 dapui.eval
    for _, buf in pairs(vim.api.nvim_list_bufs()) do
        local keymaps = vim.api.nvim_buf_get_keymap(buf, "n")
        for _, keymap in pairs(keymaps) do
            if keymap.lhs == "K" then
                table.insert(keymap_restore, keymap)
                pcall(vim.api.nvim_buf_del_keymap, buf, "n", "K")
            end
        end
        pcall(vim.keymap.set, "n", "K", dapui.eval, { buffer = buf, silent = true })
    end

    -- 兜底：会话真正关闭时（含 disconnect 超时、adapter 崩溃等异常路径）触发
    -- on_close 可能在 libuv 事件循环里被调用，非 API 安全，必须走 vim.schedule
    if session and type(session) == "table" then
        session.on_close = session.on_close or {}
        session.on_close["dapui_config"] = function()
            vim.schedule(cleanup)
        end
    end
end

-- 正常路径：由 adapter 响应/事件快速关闭
dap.listeners.after.event_terminated["dapui_config"] = on_end
dap.listeners.after.disconnect["dapui_config"] = on_end
dap.listeners.after.terminate["dapui_config"] = on_end
dap.listeners.after.event_exited["dapui_config"] = on_end
