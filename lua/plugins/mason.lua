require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	-- a list of all tools you want to ensure are installed upon
	-- start; they should be the names Mason uses for each tool
	ensure_installed = {
		{ "cpptools", version = "1.8.1" }, -- Newer version doesn't work
        "codespell",
		"lua-language-server",
		"stylua",
		"vim-language-server",
		"cmake-language-server",
		"cmakelang",
		"pyright",
        "texlab",
        "shfmt",
        "typescript-language-server"
	},

	-- if set to true this will check each tool for updates. If updates
	-- are available the tool will be updated. This setting does not
	-- affect :MasonToolsUpdate or :MasonToolsInstall.
	-- Default: false
	auto_update = false,

	-- automatically install / update on startup. If set to false nothing
	-- will happen on startup. You can use :MasonToolsInstall or
	-- :MasonToolsUpdate to install tools and check for updates.
	-- Default: true
	run_on_start = true,

	-- set a delay (in ms) before the installation starts. This is only
	-- effective if run_on_start is set to true.
	-- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
	-- Default: 0
	start_delay = 3000, -- 3 second delay
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
