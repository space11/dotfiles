local M = {
  "rose-pine/neovim",
  name = "rose-pine",
  priority = 1000,
}

function M.config()
  vim.cmd.colorscheme "rose-pine"
end

return M
