local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- General

-- Set leader
map("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Remap for command mode
map("n", ";", ":", opts)

-- Toggle wrap
map("n", "<leader>w", ":lua vim.wo.wrap = not vim.wo.wrap<CR>", { desc = "Toggle [w]rap" })

-- Smart newline for clearing search highlights
map("n", "<CR>", [[{-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()]], { silent = true, expr = true })

-- Count occurrences
map("n", ",*", "*<C-O>:%s///gn<CR>", { desc = "Count word occurrences" })

-- Better window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)
-- toggle between current and previous buffer
map("n", "<m-tab>", "<c-6>", opts)

map("n", "n", "nzz", opts)
map("n", "N", "Nzz", opts)
map("n", "*", "*zz", opts)
map("n", "#", "#zz", opts)
map("n", "g*", "g*zz", opts)
map("n", "g#", "g#zz", opts)
-- map("n", "gd", "gdzz", opts)
map("n", "G", "Gzz", opts)

map("n", "j", "jzz")
map("n", "k", "kzz")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Swap deleted character(key x) with the one before
map("x", "<leader>p", [["_dP]])

-- Navigation to first and last character in the line
map({ "n", "o", "x" }, "<s-h>", "^", opts) -- first non blank character
map({ "n", "o", "x" }, "<s-l>", "g_", opts) -- last non blank character

map("n", "<c-;>", "yyp", { desc = "Duplicate current line and keep cursor row" })

-- Remap for dealing with word wrap
map(
	"n",
	"<leader>tw",
	":lua vim.wo.wrap = not vim.wo.wrap<CR>",
	{ noremap = true, silent = true, desc = "Toggle [w]rap" }
)
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true }) -- scroll up
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true }) -- scroll down

-- Diagnostic keymaps
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
		vim.cmd("normal! zz")
	end
end
-- map("n", "[d", diagnostic_goto(false), { desc = "Go to previous diagnostic message" })
-- map("n", "]d", diagnostic_goto(true), { desc = "Go to next diagnostic message" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Go to previous error message" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Go to next error message" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Exit terminal
vim.api.nvim_set_keymap("t", "<C-;>", "<C-\\><C-n>", opts)

-- move selected line up or down
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- joins the current line with the line below it and move cursor back to its original position
map("n", "J", "mzJz")

-- This is going to get me cancelled
map("i", "<C-c>", "<Esc>")
map("n", "<C-c>", "<CMD>bd<CR>", { desc = "[C]lose Actual Buffer" })

-- Auto-indents the pasted content based on the surrounding context.
map({ "n", "v" }, "p", "p\\[=]")

map("n", ";", ":", { noremap = true, silent = true })
vim.keymap.set("n", "<CR>", [[{-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()]], { silent = true, expr = true })

-- Count occurence of word under the cursor. https://vim.fandom.com/wiki/Count_number_of_matches_of_a_pattern
map("n", ",*", "*<C-O>:%s///gn<CR>", { desc = "Count occurence of word under cursor" })

-- Install additional spel files in ~/.config/nvim/spell
-- curl -O https://ftp.nluug.nl/pub/vim/runtime/spell/pl.utf-8.spl                                                                                                                                                    SIGINT   simple-config  2⬆  5✎  2+  2⚑
-- Toggle spell check
vim.keymap.set("n", "<leader>ts", function()
	if vim.wo.spell then
		vim.wo.spell = false
		print("Spell check OFF")
	else
		vim.opt.spelllang = { "en_gb", "pl" }
		vim.wo.spell = true
		print("Spell check ON (en_gb, pl)")
	end
end, { desc = "Toggle [s]pell Check (en_gb + pl)" })
