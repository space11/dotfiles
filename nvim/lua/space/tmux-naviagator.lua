local M = {
  "christoomey/vim-tmux-navigator",
  lazyt = false,
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
  keys = {
    { "<m-h>", "<cmd>TmuxNavigateLeft<cr>" },
    { "<m-j>", "<cmd>TmuxNavigateDown<cr>" },
    { "<m-k>", "<cmd>TmuxNavigateUp<cr>" },
    { "<m-l>", "<cmd>TmuxNavigateRight<cr>" },
    { "<m-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  },
  -- config = function()
  --   vim.g.tmux_navigator_no_mappings = 1
  --   -- Keybindings for seamless navigation between tmux panes and Neovim splits
  --   vim.keymap.set("n", "<M-h>", ":TmuxNavigateLeft<CR>", { silent = true, noremap = true })
  --   vim.keymap.set("n", "<M-l>", ":TmuxNavigateRight<CR>", { silent = true, noremap = true })
  --   vim.keymap.set("n", "<M-k>", ":TmuxNavigateUp<CR>", { silent = true, noremap = true })
  --   vim.keymap.set("n", "<M-j>", ":TmuxNavigateDown<CR>", { silent = true, noremap = true })
  -- end,
}
return M
