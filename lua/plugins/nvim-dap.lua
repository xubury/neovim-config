local dap = require("dap")
local u = require("utils")


u.map("n", "<F4>", ":lua require'dap'.terminate()<cr>")
u.map("n", "<F5>", ":lua require'dap'.continue()<cr>")
u.map("n", "<F9>", ":lua require'dap'.toggle_breakpoint()<cr>")
u.map("n", "<leader><F9>", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))")
u.map("n", "<F10>", ":lua require'dap'.step_over()<cr>")
u.map("n", "<F11>", ":lua require'dap'.step_into()<cr>")
u.map("n", "<F12>", ":lua require'dap'.step_out()<cr>")

dap.adapters.lldb = {
  type = 'executable',
  command = 'lldb-vscode',
  name = "lldb"
}

local dapui  = require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_stopped["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

dapui.setup()


dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    runInTerminal = false,
  },
}
