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
  local actions = null_ls.builtins.code_actions
  local competition = null_ls.builtins.completion

  null_ls.setup {
    debug = false,
    sources = {
      formatting.stylua,
      -- formatting.prettier,
      formatting.goimports,
      -- formatting.gofumpt,

      null_ls.builtins.code_actions.gitsigns,
      diagnostics.revive,
      -- competition.spell,
      actions.gomodifytags, -- Go tool to modify struct field tag
      diagnostics.codespell,
      formatting.prettier.with {
        extra_filetypes = { "toml" },
        extra_args = { "--single-quote", "--jsx-single-quote" },
      },
      -- formatting.eslint,
      diagnostics.eslint_d.with {
        condition = function(utils)
          local v = utils.root_has_file { ".eslintrc.js", ".eslintrc.json", ".eslintrc.cjs" }
          -- return v
          return false
        end,
      },
    },
  }
end

return M
