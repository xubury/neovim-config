local u = require("utils")
local g = vim.g
local fn = vim.fn

u.map('v', "<space>/", "<Plug>NERDCommenterSexy")
u.map('n', "<space>/", "<Plug>NERDCommenterSexy")

if fn.has('win32') > 0 or fn.has('win32unix') > 0 then
    u.map('v', "<C-/>", "<Plug>NERDCommenterToggle")
    u.map('n', "<C-/>", "<Plug>NERDCommenterToggle")
else
    u.map('v', "<C-_>", "<Plug>NERDCommenterToggle")
    u.map('n', "<C-_>", "<Plug>NERDCommenterToggle")
end

-- Add spaces after comment delimiters by default
g.NERDSpaceDelims = 1

-- Use compact syntax for prettified multi-line comments
g.NERDCompactSexyComs = 1

-- Align line-wise comment delimiters flush left instead of following code indentation
g.NERDDefaultAlign = 'left'

-- Enable trimming of trailing whitespace when uncommenting
g.NERDTrimTrailingWhitespace = 1

-- Enable NERDCommenterToggle to check all selected lines is commented or not
g.NERDToggleCheckAllLines = 1
