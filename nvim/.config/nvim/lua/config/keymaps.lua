local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Down (visual line)" })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Up (visual line)" })

map("n", "[b", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

map({ "n", "x", "o" }, "0", "g0", { desc = "Start of visual line" })
map({ "n", "x", "o" }, "^", "g^", { desc = "First non-blank on visual line" })
map({ "n", "x", "o" }, "$", "v:count == 0 ? 'g$' : '$'", { expr = true, desc = "End of visual line" })
map({ "n", "x", "o" }, "L", "v:count == 0 ? 'g$' : '$'", { expr = true, desc = "End of visual line" })

map("v", "<", "<gv", { desc = "Keep selection when outdenting" })
map("v", ">", ">gv", { desc = "Keep selection when indenting" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

map("n", "<leader>w", function()
  vim.opt.wrap = not vim.opt.wrap:get()
end, { desc = "Toggle wrap" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line diagnostics" })

map("n", "<C-s>", "van", { remap = true, desc = "TS: select node at cursor" })
map("x", "<C-s>", "an", { remap = true, desc = "TS: expand to parent node" })
map("x", "<BS>", "in", { remap = true, desc = "TS: shrink to child node" })
