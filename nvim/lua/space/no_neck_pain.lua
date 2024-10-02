local M = {
	"shortcuts/no-neck-pain.nvim",
	event = "VeryLazy",

	config = function()
		local wk = require("which-key")
		wk.add({
			{ "<leader>n", desc = "No Neck Pain", icon = "🤕" },
		})
		local nn = require("no-neck-pain")
		nn.setup({
			width = 120,
			autocmds = { enableOnVimEnter = true },
			mappings = { enabled = true },
			buffers = {
				scratchPad = {
					pathToFile = "~/Documents/Personal/vim-notes/",
					colors = {
						background = "#fff",
						text = "#fff",
					},
				},
			},
		})
	end,
}
return M
