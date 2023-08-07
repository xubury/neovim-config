require("mason-lspconfig").setup({
	automatic_installation = true,
})

local nvim_lsp = require("lspconfig")

vim.lsp.set_log_level("ERROR")

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_attach = require("keymap").on_attach

local function lsp_setup(lsp, extra)
	local defaults = {
		on_attach = on_attach,
		capabilities = capabilities,
	}
	nvim_lsp[lsp].setup(vim.tbl_extend("force", defaults, extra or {}))
end

lsp_setup("vimls") -- Vim

-- Lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
lsp_setup("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false, -- THIS IS THE IMPORTANT LINE TO ADD
			},
			semantic = {
				enable = false,
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

-- cpp
local clangd_cap = vim.deepcopy(capabilities)
clangd_cap.offsetEncoding = { "utf-16" }
lsp_setup("clangd", {
	capabilities = clangd_cap,
	cmd = { "clangd", "--background-index", "--header-insertion=never" },
	filetypes = { "c", "cpp", "objc", "objcpp" },
})

-- cmake
lsp_setup("neocmake")

-- python
lsp_setup("pyright")

-- typescript
lsp_setup("tsserver")

-- vue
lsp_setup("volar")

lsp_setup("csharp_ls")

-- Sign icons
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- null-ls integration
local null_ls = require("null-ls")
null_ls.setup({
	on_attach = on_attach,
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.cmake_format,
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.prettier.with({ extra_args = { "--tab-width", "4" } }),
	},
})

require("mason-null-ls").setup({
	automatic_installation = true,
})
