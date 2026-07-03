return {
  "nvim-treesitter/nvim-treesitter-context",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    max_lines = 3,
    multiline_threshold = 20,
    trim_scope = "outer",
    mode = "cursor",
    line_numbers = true,
    separator = "-",
  },
  keys = {
    { "<leader>tc", "<cmd>TSContextToggle<CR>", desc = "Toggle treesitter context" },
  },
}
