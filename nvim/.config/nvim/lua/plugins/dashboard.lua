return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      [[                                                       ]],
      [[  ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗]],
      [[  ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║]],
      [[  ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║]],
      [[  ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║]],
      [[  ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║]],
      [[  ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
      [[                                                       ]],
    }

    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find file",       "<cmd>lua Snacks.picker.files()<CR>"),
      dashboard.button("r", "  Recent files",    "<cmd>lua Snacks.picker.recent()<CR>"),
      dashboard.button("g", "  Live grep",       "<cmd>lua Snacks.picker.grep()<CR>"),
      dashboard.button("n", "  New file",        "<cmd>ene<CR>"),
      dashboard.button("e", "  File explorer",   "<cmd>Oil<CR>"),
      dashboard.button("l", "  Lazy",            "<cmd>Lazy<CR>"),
      dashboard.button("m", "  Mason",           "<cmd>Mason<CR>"),
      dashboard.button("q", "  Quit",            "<cmd>qa<CR>"),
    }

    dashboard.section.footer.val = "nvim " .. tostring(vim.version())

    alpha.setup(dashboard.config)
  end,
}
