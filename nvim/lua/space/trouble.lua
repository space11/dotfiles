return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function()
    local wk = require "which-key"

    wk.register {
      ["<leader>xx"] = { function() require("trouble").toggle("diagnostics") end, "Trouble Toggle", },
      ["<leader>xw"] = { function() require("trouble").toggle "workspace_diagnostics" end, "Trouble Workspace Diagnostics", },
      ["<leader>xd"] = { function() require("trouble").togglel "document_diagnostics" end, "Trouble Document Diagnostics", },
      ["<leader>xq"] = { function() require("trouble").toggle "quickfix" end, "Trouble Quickfix", },
      ["<leader>xl"] = { function() require("trouble").toggle "loclist" end, "Trouble Loclist", },
    }
  end,
}
