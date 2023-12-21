-- return {
--   "catppuccin/nvim",
--   name = "catppuccin",
--   priority = 1000,
--   config = function()
--     vim.cmd([[colorscheme catppuccin]])
--   end,
-- }
--

return {
  "ellisonleao/gruvbox.nvim",
  name = "gruvbox",
  priority = 1000,
  -- config = true,
  config = function()
    vim.o.background = "dark",
        vim.cmd([[colorscheme gruvbox]])
  end

}
