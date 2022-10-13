require("mason").setup()

-- setup cpptools
local dap = require("dap")
if dap then
	local registry = require("mason-registry")
	local Path = require("plenary.path")
	local fn = vim.fn
	local cpptools_path =
		Path:new(fn.stdpath("data"), "mason", "packages", "cpptools", "extension", "debugAdapters", "bin")
	if registry.is_installed("cpptools") then
		local dst = cpptools_path / "nvim-dap.ad7Engine.json"
		if not dst:exists() then
			local src = cpptools_path / "cppdbg.ad7Engine.json"
			src:copy({ destination = dst })
		end
	end
	dap.adapters.cppdbg = {
		type = "executable",
		command = (cpptools_path / "OpenDebugAD7").filename,
		name = "cppdbg",
		options = { detached = false },
	}
end
