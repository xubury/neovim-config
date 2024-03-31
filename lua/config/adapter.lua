local Path = require("plenary.path")
local fn = vim.fn
local dap = require("dap")
local emmylua = require("emmylua")

dap.adapters.lua = emmylua.get_attach_adapter()

dap.configurations.lua = {
    {
        name = "Attach EmmyLua process",
        type = "lua",
        codePaths = { "${workspaceFolder}" },
        request = "attach",
        pid = require("dap.utils").pick_process,
        ext = { ".lua" },
    },
}

-- setup cpptools
local registry = require("mason-registry")
local cpptools_path = Path:new(fn.stdpath("data"), "mason", "packages", "cpptools", "extension", "debugAdapters", "bin")
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
