local g = vim.g

vim.keymap.set("v", "<leader>/", "<Plug>NERDCommenterSexy")
vim.keymap.set("n", "<leader>/", "<Plug>NERDCommenterSexy")

vim.keymap.set("v", "<C-_>", "<Plug>NERDCommenterToggle")
vim.keymap.set("n", "<C-_>", "<Plug>NERDCommenterToggle")
-- Add spaces after comment delimiters by default
g.NERDSpaceDelims = 1

g.NERDCreateDefaultMappings = 0

-- Use compact syntax for prettified multi-line comments
g.NERDCompactSexyComs = 1

-- Align line-wise comment delimiters flush left instead of following code indentation
g.NERDDefaultAlign = "left"

-- Enable trimming of trailing whitespace when uncommenting
g.NERDTrimTrailingWhitespace = 1

-- Enable NERDCommenterToggle to check all selected lines is commented or not
g.NERDToggleCheckAllLines = 1
