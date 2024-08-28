local telescope = require("telescope")
local actions = require("telescope.actions")
local actions_state = require("telescope.actions.state")
local project_actions = require("telescope._extensions.project.actions")

-- disable preview binaries
local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local new_maker = function(filepath, bufnr, opts)
    filepath = vim.fn.expand(filepath)
    Job:new({
        command = "file",
        args = { "--mime-type", "-b", filepath },
        on_exit = function(j)
            local mime_type = vim.split(j:result()[1], "/")[1]
            if mime_type == "text" then
                previewers.buffer_previewer_maker(filepath, bufnr, opts)
            else
                -- maybe we want to write something to the buffer here
                vim.schedule(function()
                    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
                end)
            end
        end,
    }):sync()
end

telescope.setup({
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
        project = {
            on_project_selected = function(prompt_bufnr)
                local entry = actions_state.get_selected_entry(prompt_bufnr)
                if entry then
                    project_actions.change_working_directory(prompt_bufnr, false)
                end
            end,
        },
    },
    defaults = {
        buffer_previewer_maker = new_maker,
        preview = {
            timeout = 500,
        },
        mappings = {
            i = {
                ["<Tab>"] = actions.move_selection_worse,
                ["<S-Tab>"] = actions.move_selection_better,
                ["<C-v>"] = { "<C-r>+", type = "command" },
            },
            n = {
                ["<Tab>"] = actions.move_selection_worse,
                ["<S-Tab>"] = actions.move_selection_better,
                ["<C-v>"] = { "<C-r>+", type = "command" },
            },
        },
    },
})

require("neoclip").setup({
    default_register = { '"', "+", "*" },
})

telescope.load_extension("fzf")
telescope.load_extension("project")
telescope.load_extension("neoclip")
telescope.load_extension("file_browser")
telescope.load_extension("ui-select")
