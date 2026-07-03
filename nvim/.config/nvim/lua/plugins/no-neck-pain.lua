return {
  "shortcuts/no-neck-pain.nvim",
  cmd = { "NoNeckPain", "NoNeckPainResize", "NoNeckPainWidthUp", "NoNeckPainWidthDown" },
  keys = {
    { "<leader>n", "<cmd>NoNeckPain<CR>", desc = "Toggle no-neck-pain" },
  },
  opts = {
    width = 100,
  },
}
