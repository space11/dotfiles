local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.linebreak = true
opt.breakindent = true
opt.showbreak = "↪ "

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true

opt.splitright = true
opt.splitbelow = true

opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.undofile = true
opt.swapfile = false

opt.updatetime = 250
opt.timeoutlen = 400
opt.completeopt = { "menu", "menuone", "noselect" }

opt.spelllang = { "en_us" }

opt.list = true
opt.listchars = { tab = "│ ", trail = "·", nbsp = "+" }

opt.winborder = "rounded"

opt.virtualedit = "block"

-- Folds: treesitter-driven, all-open by default, no gutter column
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldcolumn = "0"

vim.opt.shortmess:append("c")
