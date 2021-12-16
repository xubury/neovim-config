local u = require("utils")

local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local new_maker = function(filepath, bufnr, opts)
    filepath = vim.fn.expand(filepath)
    Job:new(
        {
            command = "file",
            args = {"--mime-type", "-b", filepath},
            on_exit = function(j)
                local mime_type = vim.split(j:result()[1], "/")[1]
                if mime_type == "text" then
                    previewers.buffer_previewer_maker(filepath, bufnr, opts)
                else
                    -- maybe we want to write something to the buffer here
                    vim.schedule(
                        function()
                            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {"BINARY"})
                        end
                    )
                end
            end
        }
    ):sync()
end

local actions = require "telescope.actions"
require("telescope").setup(
    {
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case" -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            }
        },
        defaults = {
            preview = {
                timeout = 500
            },
            buffer_previewer_maker = new_maker,
            mappings = {
                i = {
                    ["<Tab>"] = actions.move_selection_worse,
                    ["<S-Tab>"] = actions.move_selection_better
                },
                n = {
                    ["<Tab>"] = actions.move_selection_worse,
                    ["<S-Tab>"] = actions.move_selection_better
                }
            }
        }
    }
)

require("telescope").load_extension("fzf")

-- Telescope keymaps
u.map("n", "<C-p>", "<cmd>lua require'plugins/telescope-fn'.project_files()<cr>")
u.map("n", "<A-b>", "<cmd>Telescope buffers<cr>")
u.map("n", "<C-f>", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
u.map("n", "<leader>f", "<cmd>Telescope live_grep<cr>")
u.map("n", "<leader>h", "<cmd>Telescope help_tags<cr>")
