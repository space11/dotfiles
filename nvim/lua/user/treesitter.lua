local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

function M.config()
  require("nvim-treesitter.configs").setup {
    ensure_installed = { "lua", "markdown", "markdown_inline", "bash", "python", "query", "c", "vim", "vimdoc" },
    auto_install = false,
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = { enable = true, keymaps = { init_selection = "gnn" } },
  }
end

return M
