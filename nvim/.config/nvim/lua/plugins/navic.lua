return {
  "SmiteshP/nvim-navic",
  event = "LspAttach",
  dependencies = { "neovim/nvim-lspconfig" },
  init = function()
    vim.g.navic_silence = true
  end,
  opts = {
    lsp = { auto_attach = true },
    highlight = true,
    separator = "  ",
    depth_limit = 5,
    depth_limit_indicator = "..",
  },
  config = function(_, opts)
    require("nvim-navic").setup(opts)
    vim.opt.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
  end,
}
