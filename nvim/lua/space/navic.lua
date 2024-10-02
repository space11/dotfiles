-- LSP code context displayd in statusline / winbar
local M = {
	"SmiteshP/nvim-navic",
	event = "VeryLazy",
}

function M.config()
	local icons = require("space.icons")
	require("nvim-navic").setup({
		icons = icons.kind,
		highlight = true,
		lsp = {
			auto_attach = true,
		},
		click = true,
		separator = " " .. icons.ui.ChevronRight .. " ",
		depth_limit = 0,
		depth_limit_indicator = "..",
	})
end

return M
