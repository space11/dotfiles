local M = {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp-signature-help",
      event = "InsertEnter",
    },
    {
      "hrsh7th/cmp-nvim-lsp",
      event = "InsertEnter",
    },
    {
      "hrsh7th/cmp-emoji",
      event = "InsertEnter",
    },
    {
      "hrsh7th/cmp-buffer",
      event = "InsertEnter",
    },
    {
      "hrsh7th/cmp-path",
      event = "InsertEnter",
    },
    {
      "hrsh7th/cmp-cmdline",
      event = "InsertEnter",
    },
    {
      "saadparwaiz1/cmp_luasnip",
      event = "InsertEnter",
    },
    {
      "L3MON4D3/LuaSnip",
      event = "InsertEnter",
      dependencies = {
        "rafamadriz/friendly-snippets",
      },
      build = "make install_jsregexp",
    },
    {
      "hrsh7th/cmp-nvim-lua",
    },
    {
      "lukas-reineke/cmp-under-comparator",
    },
  },
}

function M.config()
  local cmp = require("cmp")

  cmp.setup.filetype("oil", { enabled = false })

  local luasnip = require("luasnip")
  require("luasnip/loaders/from_vscode").lazy_load()

  -- vim.api.nvim_set_hl(0, "CmpItemKindCody", { fg = "#8D3BCD" })
  vim.api.nvim_set_hl(0, "CmpItemKindCodeiu", { fg = "#09B6A2" })
  vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })

  local check_backspace = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
  end

  local icons = require("space.icons")

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert({
      -- Manually trigger cody completions
      -- ["<c-a>"] = cmp.mapping.complete({
      -- 	config = {
      -- 		sources = {
      -- 			{ name = "cody" },
      -- 		},
      -- 	},
      -- }),
      ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
      ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
      ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
      ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-e>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      -- ["<Tab>"] = cmp.mapping(function(fallback)
      --   if cmp.visible() then
      --     cmp.select_next_item()
      --   elseif luasnip.expandable() then
      --     luasnip.expand()
      --   elseif luasnip.expand_or_jumpable() then
      --     luasnip.expand_or_jump()
      --   elseif check_backspace() then
      --     fallback()
      --     -- require("neotab").tabout()
      --   else
      --     fallback()
      --     -- require("neotab").tabout()
      --   end
      -- end, {
      --   "i",
      --   "s",
      -- }),
      -- ["<S-Tab>"] = cmp.mapping(function(fallback)
      --   if cmp.visible() then
      --     cmp.select_prev_item()
      --   elseif luasnip.jumpable(-1) then
      --     luasnip.jump(-1)
      --   else
      --     fallback()
      --   end
      -- end, {
      --   "i",
      --   "s",
      -- }),
    }),
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        vim_item.kind = icons.kind[vim_item.kind]
        vim_item.menu = ({
          -- cody = "[CODY]",
          nvim_lsp = "[LSP]",
          nvim_lsp_signature_help = "[LSP_SIG]",
          codeium = "[AI]",
          nvim_lua = "",
          luasnip = "",
          buffer = "",
          path = "",
          emoji = "",
          spell = "[SPELL]",
        })[entry.source.name]

        if entry.source.name == "emoji" then
          vim_item.kind = icons.misc.Smiley
          vim_item.kind_hl_group = "CmpItemKindEmoji"
        end

        if entry.source.name == "codeium" then
          vim_item.kind = icons.misc.Robot
          vim_item.kind_hl_group = "CmpItemKindCodeiu"
        end

        return vim_item
      end,
    },
    sources = {
      -- { name = "cody" },
      -- { name = "copilot" },
      -- { name = "cmp_tabnine" },
      { name = "nvim_lsp_signature_help" },
      { name = "codeium" },
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "nvim_lua" },
      {
        { name = "buffer", keyword_length = 5 },
        { name = "path" },
      },
      -- WTF is calc?
      -- { name = "calc" },
      { name = "emoji" },
    },
    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        require("cmp-under-comparator").under,
        cmp.config.compare.kind,
      },
    },

    -- sorting = {
    --   -- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
    --   comparators = {
    --     cmp.config.compare.offset,
    --     cmp.config.compare.exact,
    --     cmp.config.compare.score,
    --
    --     -- copied from cmp-under, but I don't think I need the plugin for this.
    --     -- I might add some more of my own.
    --     function(entry1, entry2)
    --       local _, entry1_under = entry1.completion_item.label:find("^_+")
    --       local _, entry2_under = entry2.completion_item.label:find("^_+")
    --       entry1_under = entry1_under or 0
    --       entry2_under = entry2_under or 0
    --       if entry1_under > entry2_under then
    --         return false
    --       elseif entry1_under < entry2_under then
    --         return true
    --       end
    --     end,
    --
    --     cmp.config.compare.kind,
    --     cmp.config.compare.sort_text,
    --     cmp.config.compare.length,
    --     cmp.config.compare.order,
    --   },
    -- },

    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    window = {
      completion = {
        border = "rounded",
        scrollbar = false,
      },
      documentation = {
        border = "rounded",
      },
    },
    experimental = {
      ghost_text = false,
    },
  })
end

return M
