return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>lf",
      function()
        require("conform").format({ async = true, lsp_fallback = true, timeout_ms = 5000 })
      end,
      mode = { "n", "v" },
      desc = "Format file or selection",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      jsonc = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      scss = { "prettierd", "prettier", stop_after_first = true },
      yaml = { "prettierd", "prettier", stop_after_first = true },
      php = { "php_cs_fixer" },
      go = { "goimports" }, -- gofmt + canonical import management (golang.org/x/tools)
      ["_"] = { "trim_whitespace" },
    },
    formatters = {
      php_cs_fixer = {
        prefer_local = "vendor/bin",
      },
    },
    default_format_opts = { lsp_format = "fallback" },
    -- Format-on-save for Go only (the canonical Go workflow); other filetypes
    -- stay manual via <leader>lf.
    format_on_save = function(bufnr)
      if vim.bo[bufnr].filetype == "go" then
        return { timeout_ms = 3000, lsp_format = "fallback" }
      end
    end,
  },
}
