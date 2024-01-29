local g = vim.g

g.vim_markdown_math = 1
-- g.mkdp_open_to_the_world = 1
-- g.mkdp_open_ip = '127.0.0.1'
-- g.mkdp_port = 8080

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown" },
    callback = function(event)
        vim.keymap.set("n", "<leader>v", "<Plug>MarkdownPreviewToggle", {
            buffer = event.buf,
            silent = true,
        })
    end,
})
