local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
}

function M.config()
  local which_key = require "which-key"
  which_key.setup {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        win = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
    -- TODO check opts.win
    -- window = {
    --   border = "rounded",
    --   position = "bottom",
    --   padding = { 2, 2, 2, 2 },
    -- },
    -- TODO: check opts.filter
    -- ignore_missing = true,
    show_help = true,
    show_keys = true,
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  }

  local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
  }

  which_key.add {
    { "<leader>`", "<cmd>tabnew | terminal<CR>", desc = "Term" },
    { "<leader>b", group = "Buffers" },
    { "<leader>d", group = "Debug" },
    { "<leader>f", group = "Find" },
    { "<leader>g", group = "Git" },
    { "<leader>h", "<cmd>nohlsearch<CR>", desc = "NOHL" },
    { "<leader>l", group = "LSP" },
    { "<leader>p", group = "Plugins" },
    { "<leader>s", "<cmd>split<CR>", desc = "Horizontal Split" },
    { "<leader>t", group = "Tab" },
    { "<leader>tN", "<cmd>tabnew %<cr>", desc = "New Tab" },
    { "<leader>th", "<cmd>-tabmove<cr>", desc = "Move Left" },
    { "<leader>tl", "<cmd>+tabmove<cr>", desc = "Move Right" },
    { "<leader>tn", "<cmd>$tabnew<cr>", desc = "New Empty Tab" },
    { "<leader>to", "<cmd>tabonly<cr>", desc = "Only" },
    { "<leader>v", "<cmd>vsplit<CR>", desc = "Vertical Split" },
    { "<leader>x", group = "Trouble" },
  }
  which_key.setup(opts)
end

return M
