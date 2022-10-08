require("mason").setup()
require("mason-null-ls").setup({
	automatic_installation = true,
})
require("mason-lspconfig").setup({
	automatic_installation = true,
})
-- setup cpptools
local registry = require("mason-registry")
local Path = require("plenary.path")
local fn = vim.fn
local cpptools_path = Path:new(fn.stdpath("data"), "mason", "packages", "cpptools", "extension", "debugAdapters", "bin")
if registry.is_installed("cpptools") then
	local dst = cpptools_path / "nvim-dap.ad7Engine.json"
	if not dst:exists() then
		local src = cpptools_path / "cppdbg.ad7Engine.json"
		src:copy({ destination = dst })
	end
end
local dap = require("dap")
dap.adapters.cppdbg = {
	type = "executable",
	command = (cpptools_path / "OpenDebugAD7").filename,
	name = "cppdbg",
	options = { detached = false },
}
