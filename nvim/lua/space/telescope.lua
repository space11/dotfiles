local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
    {
      "LukasPietzschmann/telescope-tabs",
    },
    -- TODO: check can this work with fzf?
    -- {
    --   "nvim-telescope/telescope-live-grep-args.nvim",
    --   -- This will not install any breaking changes.
    --   -- For major updates, this must be adjusted manually.
    --   version = "^1.0.0",
    -- },
  },
}

function M.config()
  local wk = require "which-key"
  wk.register {
    ["<leader>bb"] = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },
    ["<leader>fb"] = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find files" },
    ["<leader>fp"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
    ["<leader>ft"] = { "<cmd>Telescope live_grep<cr>", "Find Text" },
    ["<leader>fh"] = { "<cmd>Telescope help_tags<cr>", "Help" },
    ["<leader>fl"] = { "<cmd>Telescope resume<cr>", "Last Search" },
    ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
    ["<leader>fs"] = { "<cmd>Telescope  lsp_document_symbols<cr>", "LSP Document Symbols" },
    ["<leader>tt"] = {
      function()
        require("telescope-tabs").list_tabs()
      end,
      "Telescope Tabs",
      mode = { "n" },
    },
  }

  local icons = require "space.icons"
  local actions = require "telescope.actions"
  -- TODO: check can this work with fzf?
  -- local lga_actions = require "telescope-live-grep-args.actions"
  local widthFn = function(_, cols, _)
    if cols > 200 then
      return 170
    else
      return math.floor(cols * 0.87)
    end
  end
  require("telescope").setup {
    defaults = {
      prompt_prefix = icons.ui.Telescope .. " ",
      selection_caret = icons.ui.Forward .. " ",
      entry_prefix = "   ",
      initial_mode = "insert",
      selection_strategy = "reset",
      path_display = { "truncate" },
      color_devicons = true,
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
      },
      layout_strategy = "center",
      layout_config = {
        vertical = {
          width = 0.9,
          height = 0.9,
          preview_height = 0.6,
          preview_cutoff = 0,
        },
      },
      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,

          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-c>"] = actions.close,
        },
        n = {
          ["<esc>"] = actions.close,
          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["q"] = actions.close,
        },
      },
    },
    pickers = {
      live_grep = {
        theme = "dropdown", -- Optional, for a dropdown appearance
        layout_config = {
          width = widthFn,
        },
        -- layout_strategy = "center", -- Use the "center" layout strategy
      },

      grep_string = {
        theme = "dropdown",
      },

      help_tags = {
        theme = "dropdown",
        previewer = true,
        hidden = true,
        layout_config = {
          width = widthFn,
        },
      },

      find_files = {
        theme = "dropdown",
        previewer = true,
        hidden = true,
        layout_config = {
          width = widthFn,
        },
      },

      oldfiles = {
        theme = "dropdown",
        previewer = true,
        hidden = true,
        layout_config = {
          width = widthFn,
        },
      },

      buffers = {
        theme = "dropdown",
        previewer = false,
        initial_mode = "normal",
        layout_config = {
          width = widthFn,
        },
        mappings = {
          i = {
            ["<C-d>"] = actions.delete_buffer,
          },
          n = {
            ["dd"] = actions.delete_buffer,
          },
        },
      },

      planets = {
        show_pluto = true,
        show_moon = true,
      },

      colorscheme = {
        enable_preview = true,
      },

      lsp_references = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_definitions = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_declarations = {
        theme = "dropdown",
        initial_mode = "normal",
        layout_config = {
          width = widthFn,
        },
      },

      lsp_implementations = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_document_symbols = {

        theme = "dropdown",
        initial_mode = "normal",
        layout_config = {
          width = widthFn,
        },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      },
      -- TODO: check can this work with fzf?
      -- live_grep_args = {
      --   auto_quoting = true, -- enable/disable auto-quoting
      --   -- define mappings, e.g.
      --   mappings = { -- extend mappings
      --     i = {
      --       ["<C-k>"] = lga_actions.quote_prompt(),
      --       ["<C-i>"] = lga_actions.quote_prompt { postfix = " --iglob " },
      --     },
      --   },
      -- },
    },
  }
end

return M
