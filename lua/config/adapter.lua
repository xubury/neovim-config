local Path = require("plenary.path")
local fn = vim.fn
local dap = require("dap")

local emmyluaPath = fn.stdpath("data") .. "/lazy/Nvim-EmmyLua"

-- dap.adapters.lua = {
--     type = "executable",
--     command = "node",
--     args = { emmyluaPath .. "/out/debugger/EmmyDebugAdapter.js" },
--     name = "lua",
-- }

-- dap.configurations.lua = {
--     {
--         name = "Launch EmmyLua",
--         type = "lua",
--         codePaths = { "${workspaceFolder}" },
--         request = "launch",
--         host = "127.0.0.1",
--         port = 9966,
--         ext = { ".lua", ".lua.txt", ".lua.bytes" },
--     },
-- }

dap.adapters.lua = {
    type = "executable",
    command = "node",
    args = { emmyluaPath .. "/out/debugger/EmmyAttachDebugAdapter.js" },
    name = "lua",
}

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

require("mason-nvim-dap").setup({
    automatic_installation = true,
})
