local cmd = vim.cmd -- execute Vim commands
local g = vim.g -- global variables
local opt = vim.opt -- global/buffer/windows-scoped options
local api = vim.api
local fn = vim.fn

local u = {}

if fn.has("win32") > 0 then
    u.num_of_processers = vim.env.NUMBER_OF_PROCESSORS
elseif fn.has("unix") > 0 then
    u.num_of_processers = tonumber(vim.fn.system("nproc"))
end

local default_opts = {noremap = true, silent = true}

function u.map(mode, key, result, opts)
    opts = opts or default_opts
    local prefix = string.sub(result, 1, 6)
    if string.lower(prefix) == "<plug>" then
        opts.noremap = false
    end
    if opts.buffer then
        local buffer_nr = opts.buffer
        opts.buffer = nil
        api.nvim_buf_set_keymap(buffer_nr, mode, key, result, opts)
    else
        api.nvim_set_keymap(mode, key, result, opts)
    end
end

function u.execute(script, ret)
    return vim.api.nvim_exec(script, ret)
end

return u
