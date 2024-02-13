local M = {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}

function M.config()
  local null_ls = require "null-ls"

  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics

  null_ls.setup {
    debug = false,
    sources = {
      formatting.stylua,
      -- formatting.prettier,
      formatting.goimports,
      -- formatting.gofumpt,

      null_ls.builtins.code_actions.gitsigns,
      diagnostics.revive,

      formatting.prettier.with {
        extra_filetypes = { "toml" },
        extra_args = { "--single-quote", "--jsx-single-quote" },
      },
      -- formatting.eslint,
      -- diagnostics.eslint_d,
    },
  }
end

return M
