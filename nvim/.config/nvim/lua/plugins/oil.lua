return {
  "stevearc/oil.nvim",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "-", "<cmd>Oil --float<CR>", desc = "Open parent directory (oil)" },
    { "<leader>e", "<cmd>Oil --float<CR>", desc = "Open file explorer" },
  },
  opts = {
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
    float = {
      padding = 2,
      max_width = 0.8,
      max_height = 0.8,
      border = "rounded",
      win_options = { winblend = 0 },
    },
    keymaps = {
      ["<C-h>"] = false,
      ["<C-l>"] = false,
      ["q"] = "actions.close",
    },
  },
}
