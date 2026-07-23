local fn = vim.fn

local u = {}

function u.dump(o)
    if type(o) == "table" then
        local s = "{ "
        for k, v in pairs(o) do
            if type(k) ~= "number" then
                k = '"' .. k .. '"'
            end
            s = s .. "[" .. k .. "] = " .. u.dump(v) .. ","
        end
        return s .. "} "
    else
        return tostring(o)
    end
end

function u.get_color(group, attr)
    return fn.synIDattr(fn.synIDtrans(fn.hlID(group)), attr)
end

-- ======== Buffer dedupe (方案 A) ========
-- 规范化路径：转绝对路径 + 统一分隔符 + 小写盘符（Windows）
local function normalize_path(p)
    if not p or p == "" then
        return nil
    end
    local abs = vim.fn.fnamemodify(p, ":p")
    local norm = vim.fs.normalize(abs)
    -- Windows 盘符大小写不敏感，统一小写化首字母
    if norm:match("^%a:") then
        norm = norm:sub(1, 1):lower() .. norm:sub(2)
    end
    return norm
end

u.normalize_path = normalize_path

-- 调试开关：设为 true 时打印去重日志
u.buffer_dedupe_debug = false

local function dedupe_log(...)
    if u.buffer_dedupe_debug then
        local parts = {}
        for i = 1, select("#", ...) do
            parts[#parts + 1] = tostring(select(i, ...))
        end
        vim.notify("[dedupe] " .. table.concat(parts, " "), vim.log.levels.INFO)
    end
end

-- 判断 buffer 是否为可去重的"文件 buffer"
local function is_file_buf(buf)
    if not vim.api.nvim_buf_is_valid(buf) then
        return false
    end
    local ok, bt = pcall(function()
        return vim.bo[buf].buftype
    end)
    if not ok then
        return false
    end
    -- 仅允许空 buftype（普通文件）；明确排除特殊类型
    return bt == ""
end

local function try_dedupe(new_buf)
    if not vim.api.nvim_buf_is_valid(new_buf) then
        return
    end
    if not is_file_buf(new_buf) then
        return
    end
    local new_name = normalize_path(vim.api.nvim_buf_get_name(new_buf))
    if not new_name then
        return
    end

    for _, b in ipairs(vim.api.nvim_list_bufs()) do
        if b ~= new_buf and is_file_buf(b) then
            local name = normalize_path(vim.api.nvim_buf_get_name(b))
            if name == new_name then
                dedupe_log("merge", new_buf, "->", b, "path=", new_name)
                -- 把所有指向 new_buf 的窗口切到 b；同时保留 new_buf 上刚设置的
                -- 光标位置（例如 spectre / LSP / gf 跳转刚 set_cursor 过），
                -- 切换 buffer 之后再把光标恢复到目标 buffer 上的同一位置。
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    if vim.api.nvim_win_get_buf(win) == new_buf then
                        local ok_pos, cursor = pcall(vim.api.nvim_win_get_cursor, win)
                        local switched = pcall(vim.api.nvim_win_set_buf, win, b)
                        if switched and ok_pos and cursor then
                            local line_count = vim.api.nvim_buf_line_count(b)
                            local lnum = math.min(cursor[1], line_count)
                            if lnum < 1 then
                                lnum = 1
                            end
                            local col = cursor[2] or 0
                            local ok_line, line = pcall(vim.api.nvim_buf_get_lines, b, lnum - 1, lnum, false)
                            if ok_line and line and line[1] then
                                col = math.min(col, #line[1])
                            end
                            if col < 0 then
                                col = 0
                            end
                            pcall(vim.api.nvim_win_set_cursor, win, { lnum, col })
                        end
                    end
                end
                -- 用 wipeout 彻底删除（含 unlisted），避免后续仍出现在 :ls!
                pcall(vim.api.nvim_buf_delete, new_buf, { force = true })
                return
            end
        end
    end
end

-- 注册多个事件：BufAdd/BufNew 捕获创建，BufReadPost/BufFilePost 捕获改名
function u.setup_buffer_dedupe()
    local group = vim.api.nvim_create_augroup("user_buffer_dedupe", { clear = true })
    vim.api.nvim_create_autocmd({ "BufAdd", "BufNew", "BufReadPost", "BufFilePost" }, {
        group = group,
        callback = function(args)
            local new_buf = args.buf
            -- 用 schedule 延迟到事件循环空闲后执行，确保 buffer 名/buftype 已设置
            vim.schedule(function()
                try_dedupe(new_buf)
            end)
        end,
    })

    -- 手动触发去重的命令（应急 / 验证用）
    vim.api.nvim_create_user_command("BufferDedupeRun", function()
        for _, b in ipairs(vim.api.nvim_list_bufs()) do
            try_dedupe(b)
        end
    end, { desc = "Manually merge duplicate file buffers" })

    vim.api.nvim_create_user_command("BufferDedupeDebug", function()
        u.buffer_dedupe_debug = not u.buffer_dedupe_debug
        vim.notify("buffer dedupe debug = " .. tostring(u.buffer_dedupe_debug))
    end, { desc = "Toggle buffer dedupe debug logging" })
end

return u
