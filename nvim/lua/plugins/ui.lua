local M = {
	-- UI components rebuild
	{
		enabled = true,
		"stevearc/dressing.nvim",
		opts = {},
	},

	-- Insert or delete brackets, parens, quotes in pair.
	{
		"windwp/nvim-autopairs",
		event = "VeryLazy",

		config = function()
			require("nvim-autopairs").setup({
				check_ts = true,
				disable_filetype = { "TelescopePrompt", "spectre_panel" },
			})
		end,
	},

	-- Use treesitter to autoclose and autorename html tag
	{
		"windwp/nvim-ts-autotag",
		-- event = { "InsertEnter" },

		config = function()
			local autotag_status_ok, autotag = pcall(require, "nvim-ts-autotag")

			if not autotag_status_ok then
				return
			end

			autotag.setup({})
		end,
	},
}

return M
