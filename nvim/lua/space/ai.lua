local M = {
	 {
    "sourcegraph/sg.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    commit ="2e8f39bc17aee7574a1dae09dc26e3d340c2bd4b",
    event = "VeryLazy",

    -- If you have a recent version of lazy.nvim, you don't need to add this!
    -- build = "nvim -l build/init.lua",
    config = function()
      require("sg").setup {
        enable_coddy = true,
      }
    end,
  },
}

return M
