local M = {
	"stevearc/oil.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
	require("oil").setup({
		lsp_file_methods = {
			-- Time to wait for LSP file operations to complete before skipping
			timeout_ms = 1000,
			-- Set to true to autosave buffers that are updated with LSP willRenameFiles
			-- Set to "unmodified" to only save unmodified buffers
			autosave_changes = "unmodified",
		},
		-- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
		delete_to_trash = true,
		skip_confirm_for_simple_edits = true,
		-- Constrain the cursor to the editable parts of the oil buffer
		-- Set to `false` to disable, or "name" to keep it on the file names
		constrain_cursor = "name",
		view_options = {
			-- Show files and directories that start with "."
			show_hidden = true,
		},
		columns = {
			"permissions",
			"size",
			"mtime",
		},
		keymaps = {
			["g="] = "actions.preview",
			["&"] = "actions.open_cmdline",
		},
	})
	vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
end

return M
