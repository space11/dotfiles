return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
  },
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
  keys = {
    { "<C-h>", "<cmd>TmuxNavigateLeft<CR>",  desc = "Navigate left (vim/tmux)" },
    { "<C-j>", "<cmd>TmuxNavigateDown<CR>",  desc = "Navigate down (vim/tmux)" },
    { "<C-k>", "<cmd>TmuxNavigateUp<CR>",    desc = "Navigate up (vim/tmux)" },
    { "<C-l>", "<cmd>TmuxNavigateRight<CR>", desc = "Navigate right (vim/tmux)" },
  },
}
