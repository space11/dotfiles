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
		local wk = require("which-key")

		wk.add({
			{
				"<leader>xd",
				function()
					require("trouble").toggle("diagnostics")
				end,
				desc = "Trouble Document Diagnostics",
			},
			{
				"<leader>xl",
				function()
					require("trouble").toggle("workspace_diagnostics")
				end,
				desc = "Trouble Loclist",
			},
			{
				"<leader>xq",
				function()
					require("trouble").togglel("document_diagnostics")
				end,
				desc = "Trouble Quickfix",
			},
			{
				"<leader>xw",
				function()
					require("trouble").toggle("quickfix")
				end,
				desc = "Trouble Workspace Diagnostics",
			},
			{
				"<leader>xx",
				function()
					require("trouble").toggle("loclist")
				end,
				desc = "Trouble Toggle",
			},
		})
	end,
}
