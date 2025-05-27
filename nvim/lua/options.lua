-- Core behavior
vim.opt.backup = false -- Disable backup file creation
vim.opt.swapfile = false -- Disable swapfile
vim.opt.writebackup = false -- Don't allow editing if file is modified elsewhere
vim.opt.undofile = false -- Disable persistent undo
-- vim.opt.fileencoding = "utf-8"          -- File encoding (safe default)

-- UI: Command line, messages
vim.opt.cmdheight = 1 -- Height of the command line
vim.opt.showmode = false -- Don't show -- INSERT --
vim.opt.shortmess:append("c") -- Avoid showing completion messages
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.laststatus = 3 -- Global statusline

-- Search
vim.opt.hlsearch = true -- Highlight search matches
vim.opt.ignorecase = true -- Ignore case...
vim.opt.smartcase = true -- ... unless capital used

-- Indentation & Tabs
vim.opt.smartindent = true -- Smart auto indent
vim.opt.shiftwidth = 2 -- Indent size
vim.opt.tabstop = 2 -- Tab character width
vim.opt.expandtab = true -- Tabs to spaces

-- Scrolling
vim.opt.scrolloff = 10 -- Lines of context when scrolling
vim.opt.sidescrolloff = 10 -- Columns of context

-- Appearance
vim.opt.termguicolors = true -- True color support
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20" -- Cursor styles
vim.opt.cursorline = true -- Highlight current line
vim.opt.number = true -- Line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.numberwidth = 4 -- Line number column width
vim.opt.signcolumn = "yes" -- Always show sign column
vim.opt.wrap = false -- Don't wrap lines
vim.opt.colorcolumn = "80" -- Show a column marker
vim.opt.virtualedit = "block" -- Allow cursor to move in visual block
vim.opt.title = false -- Disable window title
vim.opt.fillchars:append({ eob = " ", stl = " " }) -- Hide end-of-buffer ~ chars-- Appearance
vim.opt.termguicolors = true -- True color support
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20" -- Cursor styles
vim.opt.cursorline = true -- Highlight current line
vim.opt.number = true -- Line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.numberwidth = 4 -- Line number column width
vim.opt.signcolumn = "yes" -- Always show sign column
vim.opt.wrap = false -- Don't wrap lines
vim.opt.colorcolumn = "80" -- Show a column marker
vim.opt.virtualedit = "block" -- Allow cursor to move in visual block
vim.opt.title = false -- Disable window title
vim.opt.fillchars:append({ eob = " ", stl = " " }) -- Hide end-of-buffer ~ chars

-- Split behavior
vim.opt.splitbelow = true -- Horizontal split below
vim.opt.splitright = true -- Vertical split to the right
vim.opt.winminwidth = 15 -- Minimum window width (for golden_size)

-- Popup menu
vim.opt.pumheight = 10 -- Max height of popup menu
vim.opt.pumblend = 10 -- Popup menu transparency
vim.opt.completeopt = { "menuone", "noselect" } -- For completition in insert - for cmp.

-- Clipboard
vim.opt.clipboard = "unnamedplus" -- Use system clipboard

-- Timeouts
vim.opt.timeoutlen = 500 -- Key sequence timeout
vim.opt.updatetime = 100 -- CursorHold update time

-- Mouse
vim.opt.mouse = "a" -- Enable mouse in all modes

-- Folds (actual logic handled in autocmd)
vim.wo.foldenable = false
vim.opt.foldcolumn = "1"
vim.wo.foldlevel = 99

-- Whitespace/Invisible characters
-- vim.opt.list = true
-- vim.opt.listchars = "multispace:---+,lead:-,trail:-,nbsp:~,tab:▏ "
-- vim.opt.showbreak = "\\"

-- Keyword behavior
vim.cmd([[ set iskeyword+=- ]]) -- Treat dash-connected words as one

-- Navigation
vim.cmd([[ set whichwrap+=<,>,[,],h,l ]]) -- Allow arrow keys to wrap lines

-- Netrw tweaks
vim.g.netrw_mouse = 2 -- enable mouse

-- LSP diagnostics
vim.diagnostic.config({
	source = true,
	virtual_text = false,
	float = {
		border = "rounded", -- options: "single", "double", "rounded", "solid", "shadow", or a table
	},
}) -- When using multiple diagnostic providers allows to see which one reported that.

