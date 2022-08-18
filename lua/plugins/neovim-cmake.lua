local u = require("utils")
local fn = vim.fn
local CMake = require("cmake")
local Path = require('plenary.path')
local notify = require('plugins/notify')

local spinner = notify.new()

local function cmake_update_progress(lines)
    local match = string.match(lines[#lines], "(%[.*%])")
    if match then
        spinner:send_message(lines[#lines]);
    end
end

local function cmake_progress_wrapper(func, title, message, succ, err)
    local native = func
    return function()
        local job = native()
        if job then
            spinner:start({title = title, message = message})
            job:after(vim.schedule_wrap(
                function(_, exit_code)
                    if exit_code == 0 then
                        spinner:complete({message = succ, type = "info", icon =  "", timeout = 3000})
                    else
                        spinner:complete({message = err, type = "error", icon =  "", timeout = 3000})
                    end
                end
            ))
        end
        return job
    end
end

CMake.setup({
    cmake_executable = 'cmake', -- CMake executable to run.
    save_before_build = true, -- Save all buffers before building.
    parameters_file = 'neovim.json', -- JSON file to store information about selected target, run arguments and build type.
    default_parameters = {run_dir = '{cwd}', args = {}, build_type = 'Debug'},
    build_dir = tostring(Path:new('{cwd}', 'build', '{os}-{build_type}')), -- Build directory. The expressions `{cwd}`, `{os}` and `{build_type}` will be expanded with the corresponding text values. Could be a function that return the path to the build directory.
    samples_path = fn.stdpath("data") .. "/site/pack/packer/start/neovim-cmake/samples",
    default_projects_path = tostring(Path:new(vim.loop.os_homedir(), 'projects')),
    configure_args = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1', '-G', "MinGW Makefiles" }, -- Default arguments that will be always passed at cmake configure step. By default tells cmake to generate `compile_commands.json`.
    build_args = {'-j'..u.num_of_processers}, -- Default arguments that will be always passed at cmake build step.
    on_build_output = cmake_update_progress, -- Callback that will be called each time data is received by the current process. Accepts the received data as an argument.
    quickfix = {
        pos = 'botright', -- Where to open quickfix
        height = 10, -- Height of the opened quickfix.
        only_on_error = true, -- Open quickfix window only if target build failed.
    },
    copy_compile_commands = true, -- Copy compile_commands.json to current working directory.
    dap_configuration = {
        type = 'cppdbg',
        request = 'launch',
        cwd = '${workspaceFolder}'
    }, -- DAP configuration. By default configured to work with `lldb-vscode`.
    dap_open_command = require('dapui').open, -- Command to run after starting DAP session. You can set it to `false` if you don't want to open anything or `require('dapui').open` if you are using https://github.com/rcarriga/nvim-dap-ui
})

CMake.configure = cmake_progress_wrapper(CMake.configure, "CMake configure", "Start configuring...", "Configure Complete!", "Configure failed!")
CMake.build = cmake_progress_wrapper(CMake.build, "CMake build", "Start buliding...", "Build Complete!", "Build failed!")
CMake.clean = cmake_progress_wrapper(CMake.clean, "CMake clean", "Start cleaning...", "Clean Complete!", "Clean failed!")

local ProjectConfig = require('cmake.project_config')

local function cmake_try(job, ...)
    -- Check if current cwd contains CMakeLists.txt
    local project_path = Path:new(fn.getcwd())
    local cmake_project_file = project_path:joinpath('CMakeLists.txt').filename
    if fn.empty(fn.glob(cmake_project_file)) > 0 then
        -- If not, do nothing.
        return false
    end
    -- Otherwise, Check if target is selected
    local project_config = ProjectConfig.new()
    if not project_config.json.current_target then
        -- If not, select a target
        CMake.select_target(job)
        return false
    else
        if job ~= nil and type(job) == "function" then
            job(...)
            return true
        end
    end
    return false
end

local function cmake_try_build(...)
    cmake_try(CMake.build, ...)
end

local function cmake_try_build_and_run(...)
    cmake_try(CMake.build_and_run, ...)
end

local function cmake_try_build_and_debug(...)
    cmake_try(CMake.build_and_debug, ...)
end

local function cmake_try_select()
    cmake_try(CMake.select_target)
end

local function cmake_try_configure()
    cmake_try(CMake.configure)
end

vim.keymap.set("n", "<leader>g", cmake_try_configure)
vim.keymap.set("n", "<leader>s", cmake_try_select)
vim.keymap.set("n", "<leader>b", cmake_try_build)
vim.keymap.set("n", "<leader>r", cmake_try_build_and_run)
vim.keymap.set("n", "<leader>d", cmake_try_build_and_debug)

