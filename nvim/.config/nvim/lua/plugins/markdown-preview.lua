return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
  ft = { "markdown" },
  build = function()
    vim.cmd([[Lazy load markdown-preview.nvim]])
    vim.fn["mkdp#util#install"]()
  end,
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  keys = {
    { "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", desc = "Markdown preview toggle", ft = "markdown" },
  },
}
