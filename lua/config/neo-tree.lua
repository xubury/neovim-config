vim.keymap.set("n", "<C-b>", "<cmd>Neotree toggle<cr>")

require("neo-tree").setup({
    filesystem = {
        filtered_items = {
            visible = false,
            hide_dotfiles = true,
            hide_gitignored = false,
            hide_by_name = {
                ".DS_Store",
                "thumbs.db",
                "node_modules",
                "__pycache__",
            },
        },
        hijack_netrw_behavior = "open_current",
        async_directory_scan = "always",
    },
    window = {
        mappings = {
            ["<c-b>"] = function()
                vim.cmd("Neotree toggle")
            end,
            ["Z"] = { "close_all_nodes" },
            ["z"] = {},
            ["/"] = {},
            ["f"] = { "fuzzy_finder" },
            ["F"] = { "filter_on_submit" },
            ["Y"] = function(state)
                -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
                -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
                local node = state.tree:get_node()
                local filepath = node:get_id()
                local filename = node.name
                local modify = vim.fn.fnamemodify

                local results = {
                    filepath,
                    modify(filepath, ":."),
                    modify(filepath, ":~"),
                    filename,
                    modify(filename, ":r"),
                    modify(filename, ":e"),
                }

                vim.ui.select({
                    "1. Absolute path: " .. results[1],
                    "2. Path relative to CWD: " .. results[2],
                    "3. Path relative to HOME: " .. results[3],
                    "4. Filename: " .. results[4],
                    "5. Filename without extension: " .. results[5],
                    "6. Extension of the filename: " .. results[6],
                }, { prompt = "Choose to copy to clipboard:" }, function(choice)
                    if choice then
                        local i = tonumber(choice:sub(1, 1))
                        local result = results[i]
                        vim.fn.setreg("+", result)
                        vim.notify("Copied: " .. result)
                    end
                end)
            end,
        },
    },
})
