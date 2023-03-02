local u = require("util")
local tasks = require("tasks")
local Path = require("plenary.path")

tasks.setup({
	default_params = {
		cmake = {
			cmd = "cmake", -- CMake executable to use, can be changed using `:Task set_module_param cmake cmd`.
			build_dir = tostring(Path:new("{cwd}", "build", "{os}-{build_type}")), -- Build directory. The expressions `{cwd}`, `{os}` and `{build_type}` will be expanded with the corresponding text values. Could be a function that return the path to the build directory.
			build_type = "Debug", -- Build type, can be changed using `:Task set_module_param cmake build_type`.
			dap_name = "cppdbg", -- DAP configuration name from `require('dap').configurations`. If there is no such configuration, a new one with this name as `type` will be created.
			args = { -- Task default arguments.
				configure = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1", "-G", "MinGW Makefiles" },
				build = { "-j" .. u.num_of_processers }, -- Default arguments that will be always passed at cmake build step.
			},
		},
	},
	params_file = "neovim.json",
	dap_open_command = require("dapui").open, -- Command to run after starting DAP session. You can set it to `false` if you don't want to open anything or `require('dapui').open` if you are using https://github.com/rcarriga/nvim-dap-ui
	quickfix = {
		pos = "botright", -- Where to open quickfix
		height = 10, -- Height of the opened quickfix.
		only_on_error = false, -- Open quickfix window only if target build failed.
	},
})

vim.keymap.set("n", "<leader>c", "<cmd>Task start cmake build<cr>")
vim.keymap.set("n", "<leader>r", "<cmd>Task start cmake run<cr>")
vim.keymap.set("n", "<leader>d", "<cmd>Task start cmake debug<cr>")
