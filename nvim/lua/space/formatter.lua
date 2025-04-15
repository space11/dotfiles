local M = {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  -- event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        svelte = { "prettierd", "prettier", stop_after_first = true },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettier", "prettierd", stop_after_first = true, timeout_ms = 500 },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        graphql = { "prettierd", "prettier", stop_after_first = true },
        java = { "google-java-format" },
        kotlin = { "ktlint" },
        ruby = { "standardrb" },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        erb = { "htmlbeautifier" },
        html = { "htmlbeautifier" },
        bash = { "beautysh" },
        proto = { "buf" },
        rust = { "rustfmt" },
        yaml = { "yamlfix" },
        toml = { "taplo" },
        css = { "prettierd", "prettier", stop_after_first = true },
        scss = { "prettierd", "prettier", stop_after_first = true },
        angular = { "prettierd", "prettier", stop_after_first = true },
        sql = { "sql_formatter", stop_after_first = true },
        ["*"] = { "injected" },
      },
      -- Set default options
      default_format_opts = {
        lsp_format = "fallback",
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>lf", function()
      conform.format({
        lsp_fallback = true,
        async = true,
        timeout_ms = 500,
      })
    end, {
      desc = "Format file or range (in visual mode)",
    })
  end,
}

return M
