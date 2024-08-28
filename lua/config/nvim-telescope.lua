local telescope = require("telescope")
local actions = require("telescope.actions")
local actions_state = require("telescope.actions.state")
local project_actions = require("telescope._extensions.project.actions")

local previewers = require("telescope.previewers")
local _bad = { ".*%.csv", ".*%.scm", ".*%.asset" }
local bad_files = function(filepath)
    for _, v in ipairs(_bad) do
        if filepath:match(v) then
            return false
        end
    end

    return true
end

local new_maker = function(filepath, bufnr, opts)
    opts = opts or {}
    if opts.use_ft_detect == nil then
        opts.use_ft_detect = true
    end
    opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)
    previewers.buffer_previewer_maker(filepath, bufnr, opts)
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
    pickers = {
        find_files = {
            find_command = { "rg", "--files", "--color", "never", "--no-require-git" },
            preview = false,
        },
    },
    defaults = {
        buffer_previewer_maker = new_maker,
        preview = {
            timeout = 500,
            check_mime_type = true,
        },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
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
