local fn = vim.fn
local execute = vim.api.nvim_command
local M = {}

function M.CompileGCC()
    if fn.empty(fn.glob('CMakeLists.txt')) <= 0 then
        execute("CMakeBuild")
    elseif not fn.empty(fn.glob('Makefile')) <= 0 then
        execute("Dispatch make")
    else
        execute("!mkdir build")
        execute("Make")
    end
end

return M
