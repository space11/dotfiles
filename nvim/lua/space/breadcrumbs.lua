local M = {
	"LunarVim/breadcrumbs.nvim",
	event = "VeryLazy",
}

function M.config()
	require("breadcrumbs").setup()
end

return M
