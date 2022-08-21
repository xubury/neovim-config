local nvim_lsp = require("lspconfig")

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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local function lsp_setup(lsp, extra)
	local defaults = { on_attach = on_attach, debounce_text_changes = 150, capabilities = capabilities }
	nvim_lsp[lsp].setup(vim.tbl_extend("force", defaults, extra or {}))
end

lsp_setup("vimls") -- Vim

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
lsp_setup("sumneko_lua", {
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
-- Lua

lsp_setup("clangd", {
	cmd = { "clangd", "--background-index", "--header-insertion=never" },
	filetypes = { "c", "cpp", "objc", "objcpp" },
}) -- cpp
lsp_setup("cmake") -- cmake
lsp_setup("texlab") -- latex
lsp_setup("pyright") --python

-- LSP notify integration
local notify = require("plugins/notify")
local progress = {}
vim.lsp.handlers["$/progress"] = function(_, result, ctx)
	local client_id = ctx.client_id
	local client_name = vim.lsp.get_client_by_id(client_id).name
	if client_name == "null-ls" then
		return
	end

	local val = result.value
	if not val.kind then
		return
	end
	if progress[client_id] == nil then
		progress[client_id] = {}
	end
	if progress[client_id][result.token] == nil then
		progress[client_id][result.token] = notify.new()
	end
	local p = progress[client_id][result.token]
	if val.kind == "begin" then
		p:start({ client_name = client_name, title = val.title, message = val.message, percentage = val.percentage })
	elseif p and val.kind == "report" then
		p:send_message(val.message, val.percentage)
	elseif p and val.kind == "end" then
		p:complete({ message = val.message, type = "info", timeout = 500 })
	end
end

-- table from lsp severity to vim severity.
local severity = { "error", "warn", "info", "info" }

vim.lsp.handlers["window/showMessage"] = function(_, method, params, _)
	vim.notify(method.message, severity[params.type])
end

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
