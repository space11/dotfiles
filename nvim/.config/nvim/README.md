# temp-neovim-config

Simple but scalable Neovim 0.12.2 starter config in Lua, managed by [lazy.nvim](https://github.com/folke/lazy.nvim).

## Launch

This config is designed to be used via `NVIM_APPNAME` so it stays isolated from your main config at `~/.config/nvim`.

```bash
mkdir -p ~/.config
ln -s ~/temp-neovim-config ~/.config/temp-neovim-config
NVIM_APPNAME=temp-neovim-config nvim
```

Optional alias for convenience:

```bash
alias tnv='NVIM_APPNAME=temp-neovim-config nvim'
```

Plugins, runtime, and state live under `~/.local/share/temp-neovim-config/` and `~/.local/state/temp-neovim-config/`. Nothing here touches your existing `~/.config/nvim` setup.

## First run

1. lazy.nvim bootstraps itself, opens `:Lazy`, installs all plugins.
2. Mason installs LSP servers (intelephense, ts_ls, angularls, marksman, yamlls, jsonls, dockerls, docker_compose_language_service, cssls, lua_ls) plus stylua and prettierd.
3. Restart nvim. Run `:checkhealth` to confirm everything is green.
4. Codeium: run `:Codeium Auth` once, visit the URL, paste the token back.

## Structure

```
.
├── init.lua              entry point (sets leader, loads config + lazy)
├── lua/
│   ├── config/
│   │   ├── lazy.lua      lazy.nvim bootstrap + setup
│   │   ├── options.lua   vim.opt.* settings
│   │   ├── keymaps.lua   core (non-plugin) keymaps
│   │   └── autocmds.lua  highlight-on-yank, trim trailing ws, etc.
│   └── plugins/          auto-imported by lazy ({ import = "plugins" })
│       ├── colorscheme.lua   rose-pine
│       ├── treesitter.lua    nvim-treesitter + textobjects
│       ├── snacks.lua        snacks.nvim (picker, bigfile, quickfile)
│       ├── oil.lua           oil.nvim file manager
│       ├── lsp.lua           mason + lspconfig + schemastore
│       ├── completion.lua    nvim-cmp + LuaSnip
│       ├── ui.lua            lualine + which-key
│       ├── git.lua           gitsigns
│       ├── editing.lua       Comment.nvim + nvim-autopairs
│       ├── format.lua        conform.nvim
│       ├── ai.lua            codeium.nvim
│       └── dashboard.lua     alpha-nvim
├── stylua.toml
└── .gitignore
```

To add a new plugin, drop a file into `lua/plugins/` that returns a lazy spec table. No central registry to edit.

## Key bindings

Leader is `<Space>`.

### Files / search

| Key          | Action                  |
| ------------ | ----------------------- |
| `<leader>ff` | Find files (project root)            |
| `<leader>fF` | Find files (cwd)                     |
| `<leader>fg` | Live grep with args (project root)   |
| `<leader>fG` | Live grep with args (cwd)            |
| `<leader>fb` | Buffers                              |
| `<leader>fr` | Recent files                         |
| `<leader>fw` | Grep word under cursor (project root)|
| `<leader>fW` | Grep visual selection (project root) |
| `<leader>fd` | Diagnostics                          |
| `<leader>fs` | Document symbols                     |
| `-`          | Oil parent dir                       |
| `<leader>e`  | Oil file explorer                    |

**Project root resolution**: `<leader>ff` / `<leader>fg` / `<leader>fw` / `<leader>fW` search from the project root, found by walking up from the current buffer's path until one of these markers is hit: `.git`, `package.json`, `composer.json`, `tsconfig.json`, `angular.json`, `nx.json`, `pyproject.toml`, `Cargo.toml`, `go.mod`, `Makefile`. If no marker is found (e.g. an unnamed buffer or a file outside any project), it falls back to nvim's current working directory. Use the capital-letter variants (`<leader>fF`, `<leader>fG`) to force a cwd-rooted search regardless.

### Live grep filtering

`<leader>fg` opens snacks's live grep picker, scoped to the project root. To narrow by file type or directory, call the picker with options:

| Lua snippet                                          | What it does               |
| ---------------------------------------------------- | -------------------------- |
| `:lua Snacks.picker.grep()`                          | live grep in cwd           |
| `:lua Snacks.picker.grep({ ft = "ts" })`             | only TypeScript files      |
| `:lua Snacks.picker.grep({ glob = "*.tsx" })`        | only `.tsx` files          |
| `:lua Snacks.picker.grep({ dirs = {"src/"} })`       | restrict to a directory    |
| `:lua Snacks.picker.grep({ ft = "scss", dirs = {"src/"} })` | combine                |

Navigate results with `<C-j>`/`<C-k>`, `<C-n>`/`<C-p>`, or arrow keys.

### LSP (active when an LSP attaches)

| Key          | Action               |
| ------------ | -------------------- |
| `gd`         | Go to definition     |
| `gD`         | Go to declaration    |
| `gi`         | Go to implementation |
| `gr`         | References           |
| `K`          | Hover                |
| `<leader>la` | Code action          |
| `<leader>lr` | Rename               |
| `<leader>ld` | Line diagnostics     |
| `[d` / `]d`  | Prev / next diag     |

### Formatting / editing

| Key          | Action                                     |
| ------------ | ------------------------------------------ |
| `<leader>lf` | Format file (normal) or selection (visual) |
| `gcc`        | Toggle line comment                        |
| `gc`         | Toggle comment (visual)                    |

### Git (gitsigns)

| Key          | Action                  |
| ------------ | ----------------------- |
| `]h` / `[h`  | Next / prev hunk        |
| `<leader>gp` | Preview hunk            |
| `<leader>gb` | Blame line              |
| `<leader>gr` | Reset hunk              |
| `<leader>gs` | Stage hunk              |
| `<leader>gd` | Diff this               |
| `<leader>gt` | Toggle line blame       |

### Misc

| Key          | Action                |
| ------------ | --------------------- |
| `<S-h>`/`<S-l>` | Prev / next buffer  |
| `<leader>bd` | Delete buffer         |
| `<leader>w`  | Save                  |
| `<leader>q`  | Quit                  |
| `<leader>?`  | Show buffer keymaps   |

## Promotion to main config

If you want this to replace `~/.config/nvim` later:

```bash
rm ~/.config/temp-neovim-config
# back up the existing config first
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/temp-neovim-config ~/.config/nvim
nvim   # without NVIM_APPNAME this time
```
