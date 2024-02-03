local M = {}

M.setup = function()
    local toggle_qf = function()
        local qf_exists = false
        for _, win in pairs(vim.fn.getwininfo()) do
            if win["quickfix"] == 1 then
                qf_exists = true
            end
        end
        if qf_exists == true then
            vim.cmd("cclose")
            return
        end
        if not vim.tbl_isempty(vim.fn.getqflist()) then
            vim.cmd("copen")
        end
    end

    vim.keymap.set("v", "Y", "y")
    -- CTRL-X Cut
    vim.keymap.set("v", "<C-X>", '"+x')

    -- CTRL-C Copy
    vim.keymap.set("v", "<C-c>", '"+y')

    -- CTRL-V Paste
    vim.keymap.set("n", "<C-v>", "p", { remap = true })
    vim.keymap.set("v", "<C-v>", "p", { remap = true })
    vim.keymap.set("i", "<C-v>", "<C-R>+")
    vim.keymap.set("c", "<C-v>", "<C-R>+")

    -- Use CTRL-S for saving, also in Insert mode (<C-O> doesn't work well when
    -- using completions).
    vim.keymap.set("", "<C-S>", "<cmd>update<cr>")
    vim.keymap.set("v", "<C-S>", "<C-C>:update<cr>")
    vim.keymap.set("i", "<C-S>", "<Esc>:update<cr>gi")

    -- Esc
    vim.keymap.set("i", "jj", "<Esc>")

    -- Goto last insert
    vim.keymap.set("n", "ti", "`^")
    -- Goto mark
    vim.keymap.set("n", "t", "`")

    -- Go to tab by number
    vim.keymap.set("", "<A-1>", "1gt")
    vim.keymap.set("", "<A-2>", "2gt")
    vim.keymap.set("", "<A-3>", "3gt")
    vim.keymap.set("", "<A-4>", "4gt")
    vim.keymap.set("", "<A-5>", "5gt")
    vim.keymap.set("", "<A-6>", "6gt")
    vim.keymap.set("", "<A-7>", "7gt")
    vim.keymap.set("", "<A-8>", "8gt")
    vim.keymap.set("", "<A-9>", "9gt")
    -- Last tab
    vim.keymap.set("", "<A-0>", "<cmd>tablast<cr>")
    vim.keymap.set("", "<A-W>", "<cmd>tabclose<cr>")
    vim.keymap.set("", "<leader>c", toggle_qf)

    -- Last buffer
    vim.keymap.set("", "<leader><tab>", "<cmd>b#<cr>")

    -- no highlight
    vim.keymap.set("n", "<leader>n", "<cmd>noh<cr>")

    -- remap manual
    vim.keymap.set("n", "<S-k>", "<Nop>")

    -- terminal
    vim.keymap.set("t", "<esc>", "<C-\\><C-N>")

    -- Disable command line history window
    vim.keymap.set("", "q", "<nop>")

    vim.keymap.set("n", "K", "<nop>")
    vim.keymap.set("v", "K", "<nop>")

    -- Delete trailing spaces
    vim.keymap.set("n", "<A-F>", "<cmd>let _s=@/<Bar>:%s/\\s\\+$//e<Bar>:let @/=_s<Bar><cr>")

    vim.keymap.set("", "c", '"_c')
    vim.keymap.set("", "C", '"_C')

    vim.keymap.set("", "g]", "")
    vim.keymap.set("", "g[", "")

    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "qf", "help", "git", "gitcommit", "spectre_panel", "fugitive", "fugitiveblame" },
        callback = function(event)
            vim.keymap.set("n", "q", "<cmd>close<cr>", {
                buffer = event.buf,
                silent = true,
            })
        end,
    })
end

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        async = true,
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end

-- TODO: not working
-- local lsp_range_formatting = function(bufnr)
--     vim.lsp.buf.format({
--         filter = function(client)
--             -- apply whatever logic you want (in this example, we'll only use null-ls)
--             return client.name == "null-ls"
--         end,
--         bufnr = bufnr,
--         range = {
--             ['start'] = vim.api.nvim_buf_get_mark(0, '.'),
--             ['end'] = vim.api.nvim_buf_get_mark(0, 'v'),
--         },
--     })
-- end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
M.on_attach = function(_, bufnr)
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<C-LeftMouse>", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    -- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set("n", "<space>wl", function()
    --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
    -- vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    -- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "gp", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "gn", vim.diagnostic.goto_next, opts)
    -- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
    vim.keymap.set("n", "<A-F>", lsp_formatting, opts)
    -- vim.keymap.set("v", "<A-F>", lsp_range_formatting, opts)
end

return M
