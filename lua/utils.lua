local cmd = vim.cmd -- execute Vim commands
local g = vim.g -- global variables
local opt = vim.opt -- global/buffer/windows-scoped options
local api = vim.api

local u = {}

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

return u
