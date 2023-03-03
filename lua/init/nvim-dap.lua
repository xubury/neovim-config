local dap = require("dap")

local function input_condition()
	vim.ui.input({ prompt = "Breakpoint condition: " }, function(cond)
		dap.set_breakpoint(cond)
	end)
end

vim.keymap.set("n", "<F4>", dap.terminate)
vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader><F9>", input_condition)
vim.keymap.set("n", "<F10>", dap.step_over)
vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<F12>", dap.step_out)

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "@debug", linehl = "@debug", numhl = "@debug" })
vim.fn.sign_define("DapBreakpointCondition", { text = "ﳁ", texthl = "@debug", linehl = "@debug", numhl = "@debug" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "@debug", linehl = "@debug", numhl = "@debug" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "@character", linehl = "@character", numhl = "@character" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "@exception", linehl = "@exception", numhl = "@exception" })

