vim.keymap.set("n", "<A-F>", function()
    local filetype = require("guard.filetype")
    local buf = vim.api.nvim_get_current_buf()
    if not filetype[vim.bo[buf].filetype] then
        -- Delete trailing spaces
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    else
        require("guard.format").do_fmt()
    end
end, { noremap = true, silent = true })
