lua << EOF
require('telescope').load_extension('neoclip')
require('neoclip').setup()
EOF

nnoremap <Space>y <cmd>Telescope neoclip<cr>
