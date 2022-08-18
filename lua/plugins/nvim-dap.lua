local dap = require("dap")
local dapui  = require("dapui")
local u = require("utils")

dapui.setup()

dap.adapters.cppdbg = {
  type = 'executable',
  command = 'C:\\cpptools-win32\\extension\\debugAdapters\\bin\\OpenDebugAD7.exe',
  name = "cppdbg",
  options = { detached = false },
}

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

dap.listeners.after.event_terminated["dapui_config"] = function()
    dap.repl.close()
    dapui.close()
end
dap.listeners.after.disconnect["dapui_config"] = dap.listeners.after.event_terminated["dapui_config"]

dap.listeners.before.event_exited["dapui_config"] = function()
    dap.repl.close()
    dapui.close()
end


local function input_condition()
    vim.ui.input({prompt = 'Breakpoint condition: '}, function(cond) dap.set_breakpoint(cond) end)
end

vim.keymap.set("n", "<F4>", dap.terminate)
vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader><F9>", input_condition)
vim.keymap.set("n", "<F10>", dap.step_over)
vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<F12>", dap.step_out)

local keymap_restore = {}

dap.listeners.after.event_initialized['keymap'] = function()
  for _, buf in pairs(vim.api.nvim_list_bufs()) do
    local keymaps = vim.api.nvim_buf_get_keymap(buf, 'n')
    for _, keymap in pairs(keymaps) do
      if keymap.lhs == "K" then
        table.insert(keymap_restore, keymap)
        vim.api.nvim_buf_del_keymap(buf, 'n', 'K')
      end
    end
  end
   vim.keymap.set("n", "K", dapui.eval, { silent = true })
end

dap.listeners.after.disconnect['keymap'] = function()
  for _, keymap in pairs(keymap_restore) do
        vim.keymap.set(
          keymap.mode,
          keymap.lhs,
          keymap.rhs or keymap.callback,
          { silent = keymap.silent == 1 }
        )
  end
  keymap_restore = {}
end

-- dap.listeners.after.disconnect['keymap'] = dap.listeners.after.event_terminated['keymap']
