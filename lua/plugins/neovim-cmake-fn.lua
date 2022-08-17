local ProjectConfig = require('cmake.project_config')
local CMake = require("cmake")
local M = {}

function M.cmake_try_select()
    local project_config = ProjectConfig.new()
    if not project_config.json.current_target then
        CMake.select_target()
        return true
    else
        return false
    end
end

function M.cmake_build(...)
    M.cmake_try_select()
    CMake.build(...)
end

function M.cmake_build_and_run(...)
    M.cmake_try_select()
    CMake.build_and_run(...)
end

return M
