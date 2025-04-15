local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<C-i>", "<C-i>", opts)

-- Better window navigation
keymap("n", "<m-h>", "<C-w>h", opts)
keymap("n", "<m-j>", "<C-w>j", opts)
keymap("n", "<m-k>", "<C-w>k", opts)
keymap("n", "<m-l>", "<C-w>l", opts)
keymap("n", "<m-tab>", "<c-6>", opts)

keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)
keymap("n", "gd", "gdzz", opts)
keymap("n", "G", "Gzz", opts)

keymap("n", "j", "jzz")
keymap("n", "k", "kzz")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Swap deleted character(key x) with the one before
keymap("x", "<leader>p", [["_dP]])

-- Navigation to first and last character in the line
keymap({ "n", "o", "x" }, "<s-h>", "^", opts) -- first non blank character
keymap({ "n", "o", "x" }, "<s-l>", "g_", opts) -- last non blank character

keymap("n", "<c-;>", "yyp", { desc = "Duplicate current line and keep cursor row" })

-- Remap for dealing with word wrap
keymap(
  "n",
  "<leader>w",
  ":lua vim.wo.wrap = not vim.wo.wrap<CR>",
  { noremap = true, silent = true, desc = "Toggle [w]rap" }
)
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true }) -- scroll up
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true }) -- scroll down

-- Diagnostic keymaps
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
    vim.cmd("normal! zz")
  end
end
keymap("n", "[d", diagnostic_goto(false), { desc = "Go to previous diagnostic message" })
keymap("n", "]d", diagnostic_goto(true), { desc = "Go to next diagnostic message" })
keymap("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Go to previous error message" })
keymap("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Go to next error message" })
keymap("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Exit terminal
vim.api.nvim_set_keymap("t", "<C-;>", "<C-\\><C-n>", opts)

-- move selected line up or down
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- joins the current line with the line below it and move cursor back to its original position
keymap("n", "J", "mzJ`z")

-- This is going to get me cancelled
keymap("i", "<C-c>", "<Esc>")
keymap("n", "<C-c>", "<CMD>bd<CR>", { desc = "[C]lose Actual Buffer" })
-- Auto-indents the pasted content based on the surrounding context.
keymap({ "n", "v" }, "p", "p\\[=`]")

keymap("n", ";", ":", { noremap = true, silent = true })
vim.keymap.set("n", "<CR>", [[{-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()]], { silent = true, expr = true })

-- Count occurence of word under the cursor. https://vim.fandom.com/wiki/Count_number_of_matches_of_a_pattern
keymap("n", ",*", "*<C-O>:%s///gn<CR>", { desc = "Count occurence of word under cursor" })
