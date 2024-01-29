local M = {
  "tpope/vim-fugitive",
  config = function()
    local wk = require "which-key"

    wk.register {
      ["<leader>gs"] = { "<CMD>Git<CR>", "Git Status" },
    }
  end,
}

return M
