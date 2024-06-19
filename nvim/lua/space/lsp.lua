local M = {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v1.x",
    dependencies = {
      { "neovim/nvim-lspconfig" }, -- Required
      { "williamboman/mason.nvim" }, -- Optional
      { "williamboman/mason-lspconfig.nvim" }, -- Optional
    },
    config = function()
      local lsp = require "lsp-zero"

      lsp.preset "recommended"

      lsp.ensure_installed {
        "tsserver",
        "gopls",
        "eslint",
        "rust_analyzer",
      }

      -- lsp.set_preferences(
      --     {
      --         sign_icons = {}
      --     }
      -- )

      lsp.on_attach(function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "gd", function()
          vim.lsp.buf.definition()
        end, opts)
      end)

      lsp.setup()

      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        signs = false,
        virtual_text = true,
        underline = false,
      })
    end,
  },
  -- Lua LAZYDEV
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local null_ls = require "null-ls"

      local formatting = null_ls.builtins.formatting
      local diagnostics = null_ls.builtins.diagnostics
      local actions = null_ls.builtins.code_actions

      null_ls.setup {
        sources = {
          formatting.stylua,
          -- golang
          formatting.goimports,
          formatting.sqlfmt,
          -- formatting.gofumpt,

          -- typescript
          formatting.prettier.with {
            dynamic_command = function()
              return "prettier"
            end,
            filetypes = { "json", "yaml", "markdown", "javascript", "typescript", "svelte", "vue" },
            extra_args = { "--single-quote", "--jsx-single-quote", "--print-widh 80" },
          },
          formatting.shfmt,
          formatting.sqlformat,
          null_ls.builtins.code_actions.gitsigns,
          diagnostics.revive,
          actions.gomodifytags, -- Go tool to modify struct field tag
          -- competition.spell,
          diagnostics.codespell.with { filetypes = {} },
          -- todo: need to figure out what executable to install on ubuntu.
          -- diagnostics.markdownlint,
        },
      }

      vim.keymap.set("n", "<leader>lf", ":LspZeroFormat<CR>", {desc = "LSP Format"} )
    end,
  },
}

return M
