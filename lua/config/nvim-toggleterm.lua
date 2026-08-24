-- 组装 pwsh 启动命令：
-- -NoLogo    隐藏启动横幅
-- 外层 pwsh 用 -Command 设置 UTF-8 编码，然后启动内层交互式 pwsh
local pwsh_cmd = table.concat({
    "pwsh",
    "-NoLogo",
    "-NoProfile",
    "-Command",
    "\"[Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();",
    "$PSDefaultParameterValues['Out-File:Encoding']='utf8';",
    "$PSDefaultParameterValues['*:Encoding']='utf8';",
    "pwsh -NoLogo\"",
}, " ")

local powershell_cmd = "powershell -NoLogo -NoProfile"

require("toggleterm").setup({
    shell = vim.fn.executable("pwsh") == 1 and pwsh_cmd or powershell_cmd,
})
