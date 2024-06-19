local M = {
    -- ROSEPINE-COLORSCHEME
    {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "rose-pine"
        end
    },
    -- TREESITTER
    {
        "nvim-treesitter/nvim-treesitter",
        event = {"BufReadPost", "BufNewFile"},
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects"
        },
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = {
                    "json",
                    "javascript",
                    "typescript",
                    "tsx",
                    "yaml",
                    "html",
                    "css",
                    "prisma",
                    "markdown",
                    "markdown_inline",
                    "svelte",
                    "graphql",
                    "bash",
                    "lua",
                    "vim",
                    "vimdoc",
                    "dockerfile",
                    "gitignore",
                    "query"
                },
                auto_install = false,
                highlight = {enable = false},
                indent = {enable = false},
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = false,
                        node_decremental = "<bs>"
                    }
                }
            }
        end
    },
    -- TELESCOPE
    {
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        dependencies = {
            {"nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true},
            {"nvim-lua/plenary.nvim"}
        },
        config = function()
            vim.keymap.set(
                "n",
                "<leader>?",
                require("telescope.builtin").oldfiles,
                {desc = "[?] Find recently opened files"}
            )
            vim.keymap.set(
                "n",
                "<leader><space>",
                require("telescope.builtin").buffers,
                {desc = "[ ] Find existing buffers"}
            )
            vim.keymap.set(
                "n",
                "<leader>f",
                function()
                    require("telescope.builtin").current_buffer_fuzzy_find(
                        require("telescope.themes").get_dropdown {
                            winblend = 10,
                            previewer = false
                        }
                    )
                end,
                {desc = "[/] Fuzzily search in current buffer"}
            )

            vim.keymap.set("n", "<leader>p", require("telescope.builtin").find_files, {desc = "[S]earch [F]iles"})
            vim.keymap.set("n", "<M-p>", require("telescope.builtin").find_files, {desc = "[S]earch [F]iles"})
            vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, {desc = "[S]earch [H]elp"})
            vim.keymap.set(
                "n",
                "<leader>sw",
                require("telescope.builtin").grep_string,
                {desc = "[S]earch current [W]ord"}
            )
            vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, {desc = "[S]earch by [G]rep"})
            vim.keymap.set(
                "n",
                "<leader>sd",
                require("telescope.builtin").diagnostics,
                {desc = "[S]earch [D]iagnostics"}
            )
        end
    },
    -- LUALINE
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = {"nvim-tree/nvim-web-devicons"},
        config = function()
            require("lualine").setup {
                options = {
                    icons_enabled = false,
                    theme = "onedark",
                    component_separators = "|",
                    section_separators = ""
                }
            }
        end
    },
    -- TOGGLETERM
    {
        "akinsho/toggleterm.nvim",
        event = "VeryLazy",
        config = function()
            require("toggleterm").setup {
                direction = "horizontal",
                size = 90,
                open_mapping = [[<M-j>]]
            }
        end
    },
    -- COMMENTS
    {
    'numToStr/Comment.nvim',
    event = "VeryLazy",
    config = function()
	      -- Toggle current line or with count
    vim.keymap.set('n', '<leader>/', function()
        return vim.v.count == 0
            and '<Plug>(comment_toggle_linewise_current)'
            or '<Plug>(comment_toggle_linewise_count)'
    end, { expr = true })

    -- Toggle in Op-pending mode
    vim.keymap.set('n', 'gc', '<Plug>(comment_toggle_linewise)')

    -- Toggle in VISUAL mode
    vim.keymap.set('x', '<leader>/', '<Plug>(comment_toggle_linewise_visual)')
    end
},
    -- OIL
    {
        "stevearc/oil.nvim",
        event = "VeryLazy",
        dependencies = {"nvim-tree/nvim-web-devicons"},
        config = function()
            require("oil").setup {
                lsp_file_methods = {
                    -- Time to wait for LSP file operations to complete before skipping
                    timeout_ms = 1000,
                    -- Set to true to autosave buffers that are updated with LSP willRenameFiles
                    -- Set to "unmodified" to only save unmodified buffers
                    autosave_changes = "unmodified"
                },
                -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
                delete_to_trash = true,
                skip_confirm_for_simple_edits = true,
                -- Constrain the cursor to the editable parts of the oil buffer
                -- Set to `false` to disable, or "name" to keep it on the file names
                constrain_cursor = "name",
                view_options = {
                    -- Show files and directories that start with "."
                    show_hidden = true
                }
            }
            vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", {desc = "Open parent directory"})
        end
    }
}
return M
