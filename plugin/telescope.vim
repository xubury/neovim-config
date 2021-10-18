nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-b> <cmd>Telescope file_browser<cr>
nnoremap <C-f> <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>f <cmd>Telescope live_grep<cr>
nnoremap <space>b <cmd>Telescope buffers<cr>
nnoremap <leader>h <cmd>Telescope help_tags<cr>

lua << EOF
require('telescope').setup({
    extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                           -- the default case_mode is "smart_case"
        }
    },
    defaults = require('telescope.themes').get_dropdown {
    },
})


require('telescope').load_extension('fzf')
EOF
