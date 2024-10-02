local M = {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"mason-org/mason-registry",
	},
}

function M.config()
	local servers = {
		"lua_ls",
		"cssls",
		"html",
		"ts_ls",
		"pyright",
		"bashls",
		"jsonls",
		"marksman",
		"angularls",
		-- "js-debug-adapter"
	}

	require("mason").setup({
		ui = {
			border = "rounded",
		},
	})

	require("mason-lspconfig").setup({
		ensure_installed = servers,
	})
end

return M
