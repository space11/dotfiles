return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" }, -- only load when opening files
	dependencies = {
		{
			"williamboman/mason.nvim",
			cmd = "Mason", -- loads only when `:Mason` is called
			config = true,
		},
		{ "williamboman/mason-lspconfig.nvim" },
		{ "folke/lazydev.nvim", ft = "lua", opts = {} },
		{ "hrsh7th/cmp-nvim-lsp" }, -- optional, for autocompletion support
	},
	config = function()
		require("lsp") -- assuming the config is in lua/lsp.lua
	end,
}
