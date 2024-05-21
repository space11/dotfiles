local M = {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
}

function M.config()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }
  require("harpoon").setup {
    menu = {
      width = math.floor(vim.api.nvim_win_get_width(0) * 0.7),
    },
  }

  keymap("n", "<s-m>", "<cmd>lua require('space.harpoon').mark_file()<cr>", opts)
  keymap("n", "<leader>p", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", opts)
end

function M.mark_file()
  require("harpoon.mark").add_file()
  vim.notify "󱡅  marked file"
end

return M
