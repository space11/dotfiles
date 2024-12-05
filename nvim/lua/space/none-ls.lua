local M = {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}

function M.config()
	local null_ls = require("null-ls")

	local formatting = null_ls.builtins.formatting
	local diagnostics = null_ls.builtins.diagnostics
	local actions = null_ls.builtins.code_actions

	null_ls.setup({
		-- debug = true,
		sources = {
			-- formatting.stylua,
			-- golang
			-- formatting.goimports,
			-- formatting.sqlfmt,
			-- formatting.gofumpt,

			-- typescript
			-- formatting.prettier.with({
			-- 	dynamic_command = function()
			-- 		return "prettier"
			-- 	end,
			-- 	filetypes = { "json", "yaml", "markdown", "javascript", "typescript", "svelte", "vue" },
			-- 	extra_args = { "--single-quote", "--jsx-single-quote", "--print-widh 80" },
			-- }),
			-- formatting.shfmt,
			-- formatting.sqlformat,
			null_ls.builtins.code_actions.gitsigns,
			-- diagnostics.revive,
			-- actions.gomodifytags, -- Go tool to modify struct field tag
   --    actions.gitsigns, -- Git signs written in Lua
			-- competition.spell,
			-- diagnostics.codespell.with({ filetypes = {} }),
			-- todo: need to figure out what executable to install on ubuntu.
			-- diagnostics.markdownlint,
		},
	})
end

return M
