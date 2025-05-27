-- local M = {
-- 	"hrsh7th/nvim-cmp",
-- 	event = "InsertEnter",
-- 	dependencies = {
-- 		{ "hrsh7th/cmp-nvim-lsp-signature-help", event = "InsertEnter" },
-- 		{ "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
-- 		{ "hrsh7th/cmp-emoji", event = "InsertEnter" },
-- 		{ "hrsh7th/cmp-buffer", event = "InsertEnter" },
-- 		{ "hrsh7th/cmp-path", event = "InsertEnter" },
-- 		{ "hrsh7th/cmp-cmdline", event = "InsertEnter" },
-- 		{ "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },
-- 		{
-- 			"L3MON4D3/LuaSnip",
-- 			event = "InsertEnter",
-- 			dependencies = { "rafamadriz/friendly-snippets" },
-- 			build = "make install_jsregexp",
-- 		},
-- 		{ "hrsh7th/cmp-nvim-lua" },
-- 		{ "lukas-reineke/cmp-under-comparator" },
-- 	},
-- 	config = function()
-- 		local cmp = require("cmp")
--
-- 		cmp.setup.filetype("oil", { enabled = false })
--
-- 		local luasnip = require("luasnip")
-- 		require("luasnip/loaders/from_vscode").lazy_load()
--
-- 		vim.api.nvim_set_hl(0, "CmpItemKindCody", { fg = "#8D3BCD" })
-- 		vim.api.nvim_set_hl(0, "CmpItemKindCodeiu", { fg = "#09B6A2" })
-- 		vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })
--
-- 		local check_backspace = function()
-- 			local col = vim.fn.col(".")
-- 			return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
-- 		end
--
-- 		local icons = require("icons")
--
-- 		cmp.setup({
-- 			snippet = {
-- 				expand = function(args)
-- 					luasnip.lsp_expand(args.body) --For `luasnip` users.
-- 				end,
-- 			},
-- 			mapping = cmp.mapping.preset.insert({
-- 				["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
-- 				["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
-- 				["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
-- 				["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
-- 				["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
-- 				["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
-- 				["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
-- 				["<C-e>"] = cmp.mapping({
-- 					i = cmp.mapping.abort(),
-- 					c = cmp.mapping.close(),
-- 				}),
-- 				-- -Accept currently selected item. If none selected, `select` first item.
-- 				-- -Set `select` to `false` to only confirm explicitly selected items.
-- 				["<CR>"] = cmp.mapping(function(fallback)
-- 					if cmp.visible() --[[ and cmp.get_selected_entry() ]] then
-- 						cmp.confirm({ select = false })
-- 					else
-- 						fallback() -- fallback to normal <CR>
-- 					end
-- 				end, { "i", "s" }),
-- 			}),
-- 			formatting = {
-- 				fields = { "kind", "abbr", "menu" },
-- 				format = function(entry, vim_item)
-- 					vim_item.kind = icons.kind[vim_item.kind]
-- 					vim_item.menu = ({
-- 						cody = "[CODY]",
--             nvim_lsp_signature_help = "[LSP_SIG]",
-- 						nvim_lsp = "[LSP]",
-- 						codeium = "[AI]",
-- 						nvim_lua = "",
-- 						luasnip = "",
-- 						buffer = "",
-- 						path = "",
-- 						emoji = "",
-- 						spell = "[SPELL]",
-- 					})[entry.source.name]
--
-- 					if entry.source.name == "emoji" then
-- 						vim_item.kind = icons.misc.Smiley
-- 						vim_item.kind_hl_group = "CmpItemKindEmoji"
-- 					end
--
-- 					if entry.source.name == "codeium" then
-- 						vim_item.kind = icons.misc.Robot
-- 						vim_item.kind_hl_group = "CmpItemKindCodeiu"
-- 					end
--
-- 					return vim_item
-- 				end,
-- 			},
-- 			sources = {
-- 				{ name = "nvim_lsp_signature_help" },
-- 				{ name = "codeium" },
-- 				{ name = "nvim_lsp" },
-- 				{ name = "luasnip" },
-- 				{ name = "nvim_lua" },
--         { name = "buffer", keyword_length = 5 },
--         { name = "path" },
-- 				{ name = "emoji" },
-- 			},
-- 			sorting = {
-- 				comparators = {
-- 					cmp.config.compare.offset,
-- 					cmp.config.compare.exact,
-- 					cmp.config.compare.score,
-- 					cmp.config.compare.recently_used,
-- 					require("cmp-under-comparator").under,
-- 					cmp.config.compare.kind,
-- 				},
-- 			},
--
-- 			confirm_opts = {
-- 				behavior = cmp.ConfirmBehavior.Replace,
-- 				select = false,
-- 			},
-- 			window = {
-- 				completion = {
-- 					border = "rounded",
-- 					scrollbar = false,
-- 				},
-- 				documentation = {
-- 					border = "rounded",
-- 				},
-- 			},
-- 			experimental = {
-- 				ghost_text = false,
-- 			},
-- 		})
-- 	end,
-- }

-- return M
return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-path" },
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
		},
		{ "saadparwaiz1/cmp_luasnip" },
	},
	config = function()
		local luasnip = require("luasnip")
		local cmp = require("cmp")

		local cmp_kinds = {
			Text = " ",
			Method = " ",
			Function = " ",
			Constructor = " ",
			Field = " ",
			Variable = " ",
			Class = " ",
			Interface = " ",
			Module = " ",
			Property = " ",
			Unit = " ",
			Value = " ",
			Enum = " ",
			Keyword = " ",
			Snippet = " ",
			Color = " ",
			File = " ",
			Reference = " ",
			Folder = " ",
			EnumMember = " ",
			Constant = " ",
			Struct = " ",
			Event = " ",
			Operator = " ",
			TypeParameter = " ",
		}

		cmp.setup({
			preselect = cmp.PreselectMode.None,
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered({
					border = "single",
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
				}),
				documentation = cmp.config.window.bordered({
					border = "single",
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
				}),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-m>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.jumpable(1) then
						luasnip.jump(1)
					else
						fallback()
					end
				end),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			formatting = {
				fields = { "kind", "abbr" },
				format = function(_, vim_item)
					vim_item.kind = cmp_kinds[vim_item.kind] or ""
					vim_item.menu = ""
					return vim_item
				end,
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "path" },
				{ name = "luasnip" },
			}, {}),
		})

		-- require("gmr.configs.snippets")

		luasnip.filetype_extend("javascriptreact", { "javascript" })
		luasnip.filetype_extend("typescriptreact", { "typescript" })

		vim.api.nvim_create_autocmd("CursorHold", {
			group = vim.api.nvim_create_augroup("gmr_cancel_snippet", { clear = true }),
			desc = "Cancel snippet and avoid cursor jumping to the first line of the file",
			callback = function()
				local ok, luasnip = pcall(require, "luasnip")
				if not ok then
					return
				end

				if luasnip.expand_or_jumpable() then
					vim.cmd('silent! lua require("luasnip").unlink_current()')
				end
			end,
		})
	end,
}
