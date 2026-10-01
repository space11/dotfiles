return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "rose-pine",
        globalstatus = true,
        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = {
          {
            function() return "WRAP" end,
            cond = function() return vim.wo.wrap end,
          },
          "encoding",
          "fileformat",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay = 300,
      spec = {
        { "gr", group = "LSP" },
        { "grn", desc = "Rename symbol" },
        { "gra", desc = "Code action", mode = { "n", "x" } },
        { "grr", desc = "References" },
        { "gri", desc = "Implementation" },
        { "grt", desc = "Type definition" },
        { "grx", desc = "Run codelens" },
        { "gO", desc = "Document symbols" },
      },
    },
    keys = {
      {
        "<leader>?",
        function() require("which-key").show({ global = false }) end,
        desc = "Buffer keymaps",
      },
    },
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
}
