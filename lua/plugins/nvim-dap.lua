local dap = require("dap")
local dapui  = require("dapui")

dapui.setup({
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
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
            position = "left"
        },
        {
          elements = {
            -- "repl",
            "console",
          },
          size = 0.25, -- 25% of total lines
          position = "bottom"
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
    }
})

dap.adapters.cppdbg = {
    type = 'executable',
    command = 'C:\\cpptools-win32\\extension\\debugAdapters\\bin\\OpenDebugAD7.exe',
    name = "cppdbg",
    options = { detached = false },
}

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

dap.listeners.after.event_terminated["dapui_config"] = function()
    dap.repl.close()
    dapui.close()
end
dap.listeners.after.disconnect["dapui_config"] = dap.listeners.after.event_terminated["dapui_config"]

dap.listeners.before.event_exited["dapui_config"] = function()
    dap.repl.close()
    dapui.close()
end


local function input_condition()
    vim.ui.input({prompt = 'Breakpoint condition: '}, function(cond) dap.set_breakpoint(cond) end)
end

vim.keymap.set("n", "<F4>", dap.terminate)
vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader><F9>", input_condition)
vim.keymap.set("n", "<F10>", dap.step_over)
vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<F12>", dap.step_out)

local keymap_restore = {}

dap.listeners.after.event_initialized['keymap'] = function()
  for _, buf in pairs(vim.api.nvim_list_bufs()) do
    local keymaps = vim.api.nvim_buf_get_keymap(buf, 'n')
    for _, keymap in pairs(keymaps) do
      if keymap.lhs == "K" then
        table.insert(keymap_restore, keymap)
        vim.api.nvim_buf_del_keymap(buf, 'n', 'K')
      end
    end
  end
   vim.keymap.set("n", "K", dapui.eval, { silent = true })
end

dap.listeners.after.event_terminated['keymap'] = function()
  for _, keymap in pairs(keymap_restore) do
        vim.keymap.set(
          keymap.mode,
          keymap.lhs,
          keymap.rhs or keymap.callback,
          { silent = keymap.silent == 1 }
        )
  end
  keymap_restore = {}
end

dap.listeners.after.disconnect['keymap'] = dap.listeners.after.event_terminated['keymap']

-- DAP notify integration
local notify = require("plugins/notify")
local progress = {}
dap.listeners.before['event_progressStart']['progress-notifications'] = function(session, body)
    if progress[body.progressId] == nil then
        progress[body.progressId] = notify.new()
    end
    progress[body.progressId].start({ title = body.title, message = body.message, percentage = body.percentage })
end

dap.listeners.before['event_progressUpdate']['progress-notifications'] = function(session, body)
    progress[body.progressId].send_message(body.message, body.percentage)
end

dap.listeners.before['event_progressEnd']['progress-notifications'] = function(session, body)
    progress[body.progressId].complete({ message = body.message, type = "info", timeout = 3000 })
end
