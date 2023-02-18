require("mason-lspconfig").setup({
	automatic_installation = { exclude = {
		"clangd",
	} },
})

local nvim_lsp = require("lspconfig")

vim.lsp.set_log_level("ERROR")

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "<C-LeftMouse>", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	-- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	-- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
	-- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
	-- vim.keymap.set("n", "<space>wl", function()
	--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, opts)
	-- vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	-- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "gp", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "gn", vim.diagnostic.goto_next, opts)
	-- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
	vim.keymap.set("n", "<A-F>", lsp_formatting, opts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

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
		null_ls.builtins.formatting.prettier,
	},
})

require("mason-null-ls").setup({
	automatic_installation = true,
})
