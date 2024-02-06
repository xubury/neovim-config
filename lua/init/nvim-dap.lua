local function input_condition()
    vim.ui.input({ prompt = "Breakpoint condition: " }, function(cond)
        local dap = require("dap")
        dap.set_breakpoint(cond)
    end)
end

vim.keymap.set("n", "<F4>", function()
    require("dap").terminate()
end)
vim.keymap.set("n", "<F5>", function()
    require("dap").continue()
end)
vim.keymap.set("n", "<F9>", function()
    require("dap").toggle_breakpoint()
end)
vim.keymap.set("n", "<leader><F9>", input_condition)
vim.keymap.set("n", "<F10>", function()
    require("dap").step_over()
end)
vim.keymap.set("n", "<F11>", function()
    require("dap").step_into()
end)
vim.keymap.set("n", "<F12>", function()
    require("dap").step_out()
end)

local sign = vim.fn.sign_define

sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = ""})
sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = ""})
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = ""})
