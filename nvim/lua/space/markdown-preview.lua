-- install markdown-preview.nvim without yarn or npm
local M = {
	"iamcco/markdown-preview.nvim",
	event = "VeryLazy",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
}
return M
