local function input_condition()
	local dap = require("dap")
	vim.ui.input({ prompt = "Breakpoint condition: " }, function(cond)
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

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "@debug", linehl = "@debug", numhl = "@debug" })
vim.fn.sign_define("DapBreakpointCondition", { text = "ﳁ", texthl = "@debug", linehl = "@debug", numhl = "@debug" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "@debug", linehl = "@debug", numhl = "@debug" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "@character", linehl = "@character", numhl = "@character" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "@exception", linehl = "@exception", numhl = "@exception" })
