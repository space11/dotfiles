local M = {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		{ "hrsh7th/cmp-nvim-lsp-signature-help", event = "InsertEnter" },
		{ "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
		{ "hrsh7th/cmp-emoji", event = "InsertEnter" },
		{ "hrsh7th/cmp-buffer", event = "InsertEnter" },
		{ "hrsh7th/cmp-path", event = "InsertEnter" },
		{ "hrsh7th/cmp-cmdline", event = "InsertEnter" },
		{ "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },
		{
			"L3MON4D3/LuaSnip",
			event = "InsertEnter",
			dependencies = { "rafamadriz/friendly-snippets" },
			build = "make install_jsregexp",
		},
		{ "hrsh7th/cmp-nvim-lua" },
		{ "lukas-reineke/cmp-under-comparator" },
	},
	config = function()
		local cmp = require("cmp")

		cmp.setup.filetype("oil", { enabled = false })

		local luasnip = require("luasnip")
		require("luasnip/loaders/from_vscode").lazy_load()

		vim.api.nvim_set_hl(0, "CmpItemKindCody", { fg = "#8D3BCD" })
		vim.api.nvim_set_hl(0, "CmpItemKindCodeiu", { fg = "#09B6A2" })
		vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })

		local check_backspace = function()
			local col = vim.fn.col(".")
			return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
		end

		local icons = require("icons")

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body) --For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
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
				-- -Accept currently selected item. If none selected, `select` first item.
				-- -Set `select` to `false` to only confirm explicitly selected items.
				["<CR>"] = cmp.mapping(function(fallback)
					if cmp.visible() --[[ and cmp.get_selected_entry() ]] then
						cmp.confirm({ select = false })
					else
						fallback() -- fallback to normal <CR>
					end
				end, { "i", "s" }),
			}),
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					vim_item.kind = icons.kind[vim_item.kind]
					vim_item.menu = ({
						cody = "[CODY]",
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
				{ name = "nvim_lsp_signature_help" },
				{ name = "codeium" },
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "nvim_lua" },
				{
					{ name = "buffer", keyword_length = 5 },
					{ name = "path" },
				},
				{ name = "calc" },
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
	end,
}

-- function M.config()
-- 	local cmp = require("cmp")
--
-- 	cmp.setup.filetype("oil", { enabled = false })
--
-- 	local luasnip = require("luasnip")
-- 	require("luasnip/loaders/from_vscode").lazy_load()
--
-- 	vim.api.nvim_set_hl(0, "CmpItemKindCody", { fg = "#8D3BCD" })
-- 	vim.api.nvim_set_hl(0, "CmpItemKindCodeiu", { fg = "#09B6A2" })
-- 	vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })
--
-- 	local check_backspace = function()
-- 		local col = vim.fn.col(".")
-- 		return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
-- 	end
--
-- 	local icons = require("icons")
--
-- 	cmp.setup({
-- 		snippet = {
-- 			expand = function(args)
-- 				luasnip.lsp_expand(args.body) --For `luasnip` users.
-- 			end,
-- 		},
-- 		mapping = cmp.mapping.preset.insert({
-- 			["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
-- 			["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
-- 			["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
-- 			["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
-- 			["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
-- 			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
-- 			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
-- 			["<C-e>"] = cmp.mapping({
-- 				i = cmp.mapping.abort(),
-- 				c = cmp.mapping.close(),
-- 			}),
-- 			-- -Accept currently selected item. If none selected, `select` first item.
-- 			-- -Set `select` to `false` to only confirm explicitly selected items.
-- 			["<CR>"] = cmp.mapping.confirm({ select = true }),
-- 		}),
-- 		formatting = {
-- 			fields = { "kind", "abbr", "menu" },
-- 			format = function(entry, vim_item)
-- 				vim_item.kind = icons.kind[vim_item.kind]
-- 				vim_item.menu = ({
-- 					cody = "[CODY]",
-- 					nvim_lsp = "[LSP]",
-- 					nvim_lsp_signature_help = "[LSP_SIG]",
-- 					codeium = "[AI]",
-- 					nvim_lua = "",
-- 					luasnip = "",
-- 					buffer = "",
-- 					path = "",
-- 					emoji = "",
-- 					spell = "[SPELL]",
-- 				})[entry.source.name]
--
-- 				if entry.source.name == "emoji" then
-- 					vim_item.kind = icons.misc.Smiley
-- 					vim_item.kind_hl_group = "CmpItemKindEmoji"
-- 				end
--
-- 				if entry.source.name == "codeium" then
-- 					vim_item.kind = icons.misc.Robot
-- 					vim_item.kind_hl_group = "CmpItemKindCodeiu"
-- 				end
--
-- 				return vim_item
-- 			end,
-- 		},
-- 		sources = {
-- 			{ name = "nvim_lsp_signature_help" },
-- 			{ name = "codeium" },
-- 			{ name = "nvim_lsp" },
-- 			{ name = "luasnip" },
-- 			{ name = "nvim_lua" },
-- 			{
-- 				{ name = "buffer", keyword_length = 5 },
-- 				{ name = "path" },
-- 			},
-- 			{ name = "calc" },
-- 			{ name = "emoji" },
-- 		},
-- 		sorting = {
-- 			comparators = {
-- 				cmp.config.compare.offset,
-- 				cmp.config.compare.exact,
-- 				cmp.config.compare.score,
-- 				cmp.config.compare.recently_used,
-- 				require("cmp-under-comparator").under,
-- 				cmp.config.compare.kind,
-- 			},
-- 		},
--
-- 		confirm_opts = {
-- 			behavior = cmp.ConfirmBehavior.Replace,
-- 			select = false,
-- 		},
-- 		window = {
-- 			completion = {
-- 				border = "rounded",
-- 				scrollbar = false,
-- 			},
-- 			documentation = {
-- 				border = "rounded",
-- 			},
-- 		},
-- 		experimental = {
-- 			ghost_text = false,
-- 		},
-- 	})
-- end

return M
