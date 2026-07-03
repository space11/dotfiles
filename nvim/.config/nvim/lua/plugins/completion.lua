return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
      dependencies = { "rafamadriz/friendly-snippets" },
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-d>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ count = 8 }) -- page down the candidate list
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-u>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ count = 8 }) -- page up the candidate list
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-Space>"] = cmp.mapping.complete(), -- works in GUI / kitty-protocol terminals
        ["<C-@>"] = cmp.mapping.complete(), -- terminals (esp. via tmux) send <C-@>/<Nul> for Ctrl-Space
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<C-j>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "codeium", group_index = 1, priority = 100 },
        { name = "nvim_lsp", group_index = 1, priority = 90 },
        { name = "luasnip", group_index = 1, priority = 80 },
        { name = "path", group_index = 2 },
        { name = "buffer", group_index = 2, keyword_length = 3 },
      }),
      formatting = {
        format = function(entry, item)
          local source_labels = {
            nvim_lsp = "[LSP]",
            luasnip = "[Snip]",
            buffer = "[Buf]",
            path = "[Path]",
            codeium = "[AI]",
          }
          item.menu = source_labels[entry.source.name] or ("[" .. entry.source.name .. "]")
          return item
        end,
      },
      experimental = { ghost_text = false },
    })
  end,
}
