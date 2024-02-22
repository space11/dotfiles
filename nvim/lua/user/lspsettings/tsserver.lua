local M = {
  capabilities = { offsetEncoding = { "utf-16" } },
}

local wk = require "which-key"
wk.register {
  ["<leader>lo"] = {
    "<cmd>lua vim.lsp.buf.execute_command { command = '_typescript.organizeImports', arguments = { vim.fn.expand '%:p' } }<cr>",
    "TS Organize Imports",
  },
}

return M
