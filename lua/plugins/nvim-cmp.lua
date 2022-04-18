local cmp = require "cmp"
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup(
    {
        snippet = {
            expand = function(args)
                -- For `vsnip` user.
                vim.fn["vsnip#anonymous"](args.body)
                -- For `ultisnips` user.
                -- vim.fn["UltiSnips#Anon"](args.body)
            end
        },
        -- preselect = cmp.PreselectMode.None,
        experimental = {
            ghost_text = true
        },
        completion = {
            autocomplete = false,
            completeopt = "menu,menuone,noinsert"
        },
        mapping = cmp.mapping.preset.insert(
            {
                ["<Tab>"] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
                        elseif has_words_before() then
                            cmp.complete({select = false})
                        else
                            fallback()
                        end
                    end,
                    {"i", "s"}
                ),
                ["<S-Tab>"] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item({behavior = cmp.SelectBehavior.Select})
                        elseif has_words_before() then
                            cmp.complete({select = false})
                        else
                            fallback()
                        end
                    end,
                    {"i", "s"}
                ),
                ["<Backspace>"] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() and not has_words_before() then
                            cmp.close()
                        end
                        fallback()
                    end,
                    {"i", "s"}
                ),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping(cmp.mapping.confirm({select = true}), {"i", "s", "c"}),
                ["<C-j>"] = cmp.mapping(
                    function()
                        if vim.fn["vsnip#available"]() == 1 then
                            feedkey("<Plug>(vsnip-expand-or-jump)", "")
                        end
                    end,
                    {"i", "s"}
                ),
                ["<C-k>"] = cmp.mapping(
                    function()
                        if vim.fn["vsnip#jumpable"](-1) == 1 then
                            feedkey("<Plug>(vsnip-jump-prev)", "")
                        end
                    end,
                    {"i", "s"}
                )
            }
        ),
        sources = {
            {name = "nvim_lsp"},
            {name = "vsnip"},
            {name = "path"},
            {name = "buffer"}
        }
    }
)
-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
    "/",
    {
        mapping = {
            ["<Tab>"] = {
                c = function()
                    if cmp.visible() then
                        cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
                    else
                        cmp.complete({select = false})
                    end
                end
            },
            ["<S-Tab>"] = {
                c = function()
                    if cmp.visible() then
                        cmp.select_prev_item({behavior = cmp.SelectBehavior.Select})
                    else
                        cmp.complete({select = false})
                    end
                end
            }
        },
        sources = {
            {name = "buffer"}
        }
    }
)

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
    ":",
    {
        mapping = {
            ["<Tab>"] = {
                c = function()
                    if cmp.visible() then
                        cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
                    else
                        cmp.complete({select = false})
                    end
                end
            },
            ["<S-Tab>"] = {
                c = function()
                    if cmp.visible() then
                        cmp.select_prev_item({behavior = cmp.SelectBehavior.Select})
                    else
                        cmp.complete({select = false})
                    end
                end
            }
        },
        sources = cmp.config.sources(
            {
                {name = "path"}
            },
            {
                {name = "cmdline"}
            }
        )
    }
)
