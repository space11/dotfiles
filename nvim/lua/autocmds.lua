vim.filetype.add({
	pattern = {
		[".*%.component%.html"] = "angular.html", -- Sets the filetype to `angular.html` if it matches the pattern
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "angular.html",
	callback = function()
		vim.treesitter.language.register("angular", "angular.html") -- Register the filetype with treesitter for the `angular` language/parser
	end,
})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
})

-- Toggle cursol line
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.opt.cursorline = false
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.opt.cursorline = true
  end,
})

--  Dissable vim from automatically extend comments on new lines
vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Maps q to close window
-- Trigger: when certain filetype detected.
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "netrw",
    "Jaq",
    "qf",
    "git",
    "help",
    "man",
    "lspinfo",
    "oil",
    "spectre_panel",
    "lir",
    "DressingSelect",
    "tsplayground",
    "",
  },
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
  end,
})
--
-- -- TODO: find out why it doesn't work
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { ".env*", "*env*" },
--   callback = function()
--     vim.bo.filetype = "sh"
--   end,
-- })
--
-- -- vim.api.nvim_create_autocmd({ "VimResized" }, {
-- -- 	callback = function()
-- -- 		vim.cmd("tabdo wincmd =")
-- -- 	end,
-- -- })
--
-- vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
--   pattern = { "*" },
--   callback = function()
--     vim.cmd("checktime")
--   end,
-- })
--
--
-- Enable word wrap and spell check for prose-like files (e.g. git commits, markdown)
-- Only for the current buffer
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "NeogitCommitMessage" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Auto-unlink active LuaSnip snippet when cursor is idle to avoid ghost placeholders
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    local ok, luasnip = pcall(require, "luasnip")
    if not ok then
      return
    end

    -- If a snippet node is active and can be jumped/expanded
    if luasnip.expand_or_jumpable() then
      -- Silently clean up the snippet (prevents stuck placeholders)
      pcall(function()
        luasnip.unlink_current()
      end)
    end
  end,
})

-- User command to toggle line number modes for personal vs pair programming
vim.api.nvim_create_user_command("PairMode", function()
  local number = vim.opt.number:get()
  local relativenumber = vim.opt.relativenumber:get()

  if number and relativenumber then
    -- Currently showing both → disable relative for simplicity
    vim.opt.relativenumber = false
  elseif number then
    -- Currently showing only absolute → enable relative
    vim.opt.relativenumber = true
  else
    -- Both off → enable only absolute
    vim.opt.number = true
    vim.opt.relativenumber = false
  end
end, { nargs = 0 })

-- Setup folding using Tree-sitter if available, else fallback to syntax folding
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    local ts_parsers = require("nvim-treesitter.parsers")

    if ts_parsers.has_parser() then
      -- Use Tree-sitter folding via expression
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    else
      -- Fallback: use built-in syntax folding
      vim.opt.foldmethod = "syntax"
      vim.opt.foldexpr = "" -- clear foldexpr when not using expr folding
    end
  end,
})

