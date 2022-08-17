local u = require("utils")
local fn = vim.fn
local CMake = require("cmake")
local Path = require('plenary.path')

CMake.setup({
  cmake_executable = 'cmake', -- CMake executable to run.
  save_before_build = true, -- Save all buffers before building.
  parameters_file = 'neovim.json', -- JSON file to store information about selected target, run arguments and build type.
  default_parameters = {run_dir = '{cwd}', args = {}, build_type = 'Debug'},
  build_dir = tostring(Path:new('{cwd}', 'build', '{os}-{build_type}')), -- Build directory. The expressions `{cwd}`, `{os}` and `{build_type}` will be expanded with the corresponding text values. Could be a function that return the path to the build directory.
  samples_path = fn.stdpath("data") .. "/site/pack/packer/start/neovim-cmake/samples",
  default_projects_path = tostring(Path:new(vim.loop.os_homedir(), 'projects')),
  configure_args = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1', '-G', "MinGW Makefiles" }, -- Default arguments that will be always passed at cmake configure step. By default tells cmake to generate `compile_commands.json`.
  build_args = {'-j4'..u.num_of_processers}, -- Default arguments that will be always passed at cmake build step.
  on_build_output = nil, -- Callback that will be called each time data is received by the current process. Accepts the received data as an argument.
  quickfix = {
    pos = 'botright', -- Where to open quickfix
    height = 10, -- Height of the opened quickfix.
    only_on_error = false, -- Open quickfix window only if target build failed.
  },
  copy_compile_commands = true, -- Copy compile_commands.json to current working directory.
  -- dap_configuration = {
  --   type = 'lldb',
  --   request = 'launch',
  --   stopOnEntry = false,
  --   runInTerminal = true }, -- DAP configuration. By default configured to work with `lldb-vscode`.
  dap_open_command = require('dapui').open, -- Command to run after starting DAP session. You can set it to `false` if you don't want to open anything or `require('dapui').open` if you are using https://github.com/rcarriga/nvim-dap-ui
})

u.map("n", "<F5>", ":CMake build_and_debug<cr>")
u.map("n", "<leader>g", "<cmd>CMake configure<cr>")
u.map("n", "<leader>b", "<cmd>lua require'plugins/neovim-cmake-fn'.cmake_build()<cr>")
u.map("n", "<leader>r", "<cmd>lua require'plugins/neovim-cmake-fn'.cmake_build_and_run()<cr>")
