return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      php = { "phpstan" },
    }

    -- Prefer project-local phpstan (vendor/bin/phpstan) over the Mason-installed global
    local phpstan = lint.linters.phpstan
    phpstan.cmd = function()
      local found = vim.fs.find("vendor/bin/phpstan", {
        upward = true,
        path = vim.fn.expand("%:p:h"),
      })[1]
      return found or "phpstan"
    end

    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("user_nvim_lint", { clear = true }),
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
