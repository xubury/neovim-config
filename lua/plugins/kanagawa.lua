local cmd = vim.cmd
cmd("colorscheme kanagawa")
cmd("syntax enable")

vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg=0, fg='#E82424', bg='#363646' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg=0, fg='#DCD7BA', bg='#363646' })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg=0, fg='#98BB6C', bg='#363646' })

vim.fn.sign_define('DapBreakpoint', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text='ﳁ', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl= 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text='', texthl='DapLogPoint', linehl='DapLogPoint', numhl= 'DapLogPoint' })
vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })

vim.g.kanagawa_lualine_bold = false
