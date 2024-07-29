local M = {
  "tpope/vim-fugitive",
  event = "VeryLazy",
  config = function()
    local wk = require "which-key"
    wk.add { { "<leader>gs", "<CMD>Git<CR>", desc = "Git Status" } }
  end,
}
return M
