local ft = require("guard.filetype")

ft("python"):fmt({ cmd = "black.cmd", stdin = true, args = { "--quiet", "-" } })
ft("c,cpp,glsl,json"):fmt({ cmd = "clang-format.cmd", stdin = true })
ft("lua"):fmt({ cmd = "stylua.cmd", args = { "-" }, stdin = true })
ft("javascript,typescript"):fmt({
    cmd = "prettier.cmd",
    args = { "--stdin-filepath" },
    fname = true,
    stdin = true,
})

-- Call setup() LAST!
require("guard").setup({
    -- Choose to format on every write to a buffer
    fmt_on_save = false,
    -- Use lsp if no formatter was defined for this filetype
    lsp_as_default_formatter = false,
    -- By default, Guard writes the buffer on every format
    -- You can disable this by setting:
    -- save_on_fmt = false,
})
