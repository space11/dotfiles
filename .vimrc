" General
" set linebreak	" Break lines at word (requires Wrap lines)
" set showbreak=+++	" Wrap-broken line prefix
" set textwidth=100	" Line wrap (number of cols)
set showmatch	" Highlight matching brace
" set spell	" Enable spell-checking
set visualbell	" Use visual bell (no beeping)
 
set smartcase	" Enable smart-case search
set ignorecase	" Always case-insensitive
set incsearch	" Searches for strings incrementally
 
set autoindent	" Auto-indent new lines
set smartindent	" Enable smart-indent
set smarttab	" Enable smart-tabs
 
" Advanced
set ruler	" Show row and column ruler information
 
set undolevels=1000	" Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour
 
" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Color schema
colorscheme industry

" Highlights the current line
set cursorline

" Search recursively downward from CWD; provides TAB completion for filenames
" e.g., `:find vim* <TAB>`
set path+=**

" number of lines at the beginning and end of files checked for file-specific vars
set modelines=0

" reload files changed outside of Vim not currently modified in Vim (needs below)
set autoread

" http://stackoverflow.com/questions/2490227/how-does-vims-autoread-work#20418591
au FocusGained,BufEnter * :silent! !

" use Unicode
set encoding=utf-8

" errors flash screen rather than emit beep
set visualbell

" make Backspace work like Delete
set backspace=indent,eol,start

" don't create `filename~` backups
set nobackup

" don't create temp files
set noswapfile

" line numbers and distances
set relativenumber 
set number 

" number of lines offset when jumping
set scrolloff=2

" Tab key enters 2 spaces
" To enter a TAB character when `expandtab` is in effect,
" CTRL-v-TAB
set expandtab tabstop=2 shiftwidth=2 softtabstop=2 

" Indent new line the same as the preceding line
set autoindent

" statusline indicates insert or normal mode
set showmode showcmd

" make scrolling and painting fast
" ttyfast kept for vim compatibility but not needed for nvim
set ttyfast lazyredraw

" highlight matching parens, braces, brackets, etc
set showmatch

" http://vim.wikia.com/wiki/Searching
set hlsearch incsearch ignorecase smartcase

" As opposed to `wrap`
"set nowrap

" http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
set autochdir

" open new buffers without saving current modifications (buffer remains open)
set hidden

" http://stackoverflow.com/questions/9511253/how-to-effectively-use-vim-wildmenu
set wildmenu wildmode=list:longest,full

" StatusLine always visible, display full path
" http://learnvimscriptthehardway.stevelosh.com/chapters/17.html
set laststatus=2 statusline=%F

" Use system clipboard
" http://vim.wikia.com/wiki/Accessing_the_system_clipboard
" for linux
set clipboard=unnamedplus
" for macOS
" set clipboard=unnamed

" Folding
" https://vim.fandom.com/wiki/Folding
" https://vim.fandom.com/wiki/All_folds_open_when_opening_a_file
" https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
set foldmethod=indent
set foldnestmax=1
set foldlevelstart=1

" netrw and vim-vinegar
let g:netrw_browse_split = 3

" Plugins, syntax, and colors
" ---------------------------------------------------------------------------
" vim-plug
" https://github.com/junegunn/vim-plug
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
" call plug#begin('~/.local/share/nvim/plugged')

" Make sure to use single quotes
" Install with `:PlugInstall`

" https://github.com/itchyny/lightline.vim
" Plug 'itchyny/lightline.vim'

" https://github.com/tpope/vim-commentary
" Plug 'tpope/vim-commentary'

" https://github.com/tpope/vim-surround
" Plug 'tpope/vim-surround'

" https://github.com/tpope/vim-vinegar
"Plug 'tpope/vim-vinegar'

" https://github.com/APZelos/blamer.nvim
"Plug 'APZelos/blamer.nvim'

" https://github.com/fenetikm/falcon/wiki/Installation
"Plug 'fenetikm/falcon'

" https://github.com/macguirerintoul/night_owl_light.vim
"Plug 'macguirerintoul/night_owl_light.vim'

" Initialize plugin system
"call plug#end()

syntax enable
" Neovim only
" set termguicolors 

" Light scheme
" colorscheme night_owl_light

" Dark scheme
"colorscheme falcon
"set background=dark

" Show character column
" set colorcolumn=80
" 
" " lightline config - add file 'absolutepath'
" " Delete colorscheme line below if using Dark scheme
" 
" let g:lightline = {
"       \ 'colorscheme': 'PaperColor_light',
"       \ 'actie': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'readonly', 'absolutepath', 'modified' ] ]
"       \ }
"       \ }
" 
" let g:blamer_enabled = 1
" " %a is the day of week, in case it's needed
" let g:blamer_date_format = '%e %b %Y'
" highlight Blamer guifg=darkorangev

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

