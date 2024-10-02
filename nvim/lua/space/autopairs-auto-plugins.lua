local M = {
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
	{
		"windwp/nvim-ts-autotag", -- plugin 2
		event = { "InsertEnter" },

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
