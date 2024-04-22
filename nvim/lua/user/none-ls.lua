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
  -- local completion = null_ls.builtins.completion
  local h = require "null-ls.helpers"
  local methods = require "null-ls.methods"
  local FORMATTING = methods.internal.FORMATTING
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
      diagnostics.codespell.with { filetypes = {} },
      formatting.sqlfmt,
      formatting.prettier.with {
        dynamic_command = function()
          return "prettier"
        end,
        filetypes = { "html", "json", "yaml", "markdown", "javascript", "typescript", "svelte", "vue" },
        extra_args = { "--single-quote", "--jsx-single-quote", "--print-widh 80" },
      },
      -- deleted , deprecated builtins
      -- formatting.eslint,
      -- diagnostics.eslint_d.with {
      --   condition = function(utils)
      --     local v = utils.root_has_file { ".eslintrc.js", ".eslintrc.json", ".eslintrc.cjs" }
      --     return v
      --     -- return false
      --   end,
      -- },
    },
  }
end

return M
