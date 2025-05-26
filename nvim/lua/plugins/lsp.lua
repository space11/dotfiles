-- return {
-- 	{
-- 		"neovim/nvim-lspconfig",
-- 		dependencies = {
-- 			{ "williamboman/mason.nvim", build = ":MasonUpdate" },
-- 			"williamboman/mason-lspconfig.nvim",
-- 		},
-- 		config = function()
-- 			require("mason").setup()
-- 			-- require("mason-lspconfig").setup({
-- 			-- 	ensure_installed = { "ts_ls" }, -- add what you use
-- 			-- 	handlers = {
-- 			-- 		function(server)
-- 			-- 			local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- 			-- 			require("lspconfig")[server].setup({
-- 			-- 				capabilities = capabilities,
-- 			-- 			})
-- 			-- 		end,
-- 			-- 	},
-- 			-- })
--
-- 			local function lsp_keymaps(bufnr)
-- 				local opts = { noremap = true, silent = true }
-- 				local keymap = vim.api.nvim_buf_set_keymap
-- 				-- keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
-- 				-- keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>zz", opts)
-- 				-- keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
-- 				-- keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
-- 				-- keymap(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
-- 				-- keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
-- 				keymap(
-- 					bufnr,
-- 					"n",
-- 					"K",
-- 					"<cmd>lua vim.lsp.buf.hover({ border = 'single', max_height = 25, max_width = 120 })<CR>",
-- 					opts
-- 				)
--
-- 				-- Function to trigger code action
-- 				keymap(
-- 					bufnr,
-- 					"v",
-- 					"<CR>",
-- 					"<cmd>lua vim.lsp.buf.range_code_action()<CR>",
-- 					{ desc = "LSP Range Code Action" }
-- 				)
-- 				keymap(bufnr, "n", "<CR>", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "LSP Code Action" })
-- 			end
--
-- 			local on_attach = function(client, bufnr)
-- 				-- log client name and bufnr
-- 				print("client name: " .. client.name .. ", bufnr: " .. bufnr)
-- 				lsp_keymaps(bufnr)
--
-- 				-- if client.supports_method("textDocument/inlayHint") then
-- 				-- 	vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
-- 				-- end
-- 				--
-- 				-- -- refresh codelens when buffer enters and buffer is saved
-- 				-- -- InsertLeave TextChanged
-- 				-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre" }, {
-- 				-- 	buffer = bufnr,
-- 				-- 	callback = vim.lsp.codelens.refresh,
-- 				-- })
--
-- 				-- trigger code lens
-- 				vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
-- 			end
--
-- 			local function common_capabilities()
-- 				-- cmp_nvim_lsp.default_capabilities() already includes standard LSP features + nvim-cmp enhancements.
-- 				local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- 				capabilities.textDocument.completion.completionItem.snippetSupport = true
-- 				return capabilities
-- 			end
--
-- 			-- Helper to disable tsserver if angularls is also attached
-- 			local function disable_tsserver_if_angularls(client)
-- 				local active_clients = vim.lsp.get_active_clients({ bufnr = 0 })
-- 				for _, c in ipairs(active_clients) do
-- 					if c.name == "angularls" then
-- 						-- Disable tsserver responses
-- 						client.server_capabilities.renameProvider = false
-- 						client.server_capabilities.referencesProvider = false
-- 						client.server_capabilities.definitionProvider = false
-- 						break
-- 					end
-- 				end
-- 			end
--
-- 			local lspconfig = require("lspconfig")
--
-- 			lspconfig.angularls.setup({
-- 				filetypes = { "typescript", "angular.html" },
-- 				on_attach = function(client, bufnr)
-- 					-- Disable overlapping features in angularls if ts_ls is attached
-- 					for _, c in ipairs(vim.lsp.get_active_clients({ bufnr = bufnr })) do
-- 						if c.name == "ts_ls" then
-- 							client.server_capabilities.renameProvider = false
-- 							client.server_capabilities.referencesProvider = false
-- 							client.server_capabilities.definitionProvider = false
-- 							break
-- 						end
-- 					end
--
-- 					on_attach(client, bufnr)
-- 				end,
-- 				capabilities = common_capabilities(),
-- 			})
--
-- 			lspconfig.ts_ls.setup({
-- 				filetypes = { "typescript" }, -- you can remove "angular.html" if it's unnecessary
-- 				on_attach = on_attach,
-- 				capabilities = common_capabilities(),
-- 			})
--
-- 			-- lua_ls is started by neodev plugin...
-- 			-- require("lspconfig").lua_ls.setup({
-- 			-- 	on_attach = on_attach,
-- 			-- 	capabilities = common_capabilities(),
-- 			-- 	settings = {
-- 			-- 		Lua = {
-- 			-- 			diagnostics = {
-- 			-- 				globals = { "vim" }, -- allow `vim` as a recognized global
-- 			-- 			},
-- 			-- 		},
-- 			-- 	},
-- 			-- })
-- 		end,
-- 	},
-- }
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", build = ":MasonUpdate" },
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("mason").setup()

		-- vim.lsp.handlers["textDocument/signatureHelp"] =
		-- 	vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single', max_height = 25, max_width = 120  })
		--
		-- vim.lsp.handlers["textDocument/hover"] =
		-- 	vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single', max_height = 25, max_width = 120  })
		local lspconfig = require("lspconfig")
		-- rust
		lspconfig.rust_analyzer.setup({
			-- `:help lspconfig-setup`
			settings = {
				["rust-analyzer"] = {
					cargo = {
						allFeatures = true,
						targetDir = true,
					},
					imports = {
						group = {
							enable = false,
						},
					},
					completion = {
						postfix = {
							enable = false,
						},
					},
				},
			},
		})

		-- python
		lspconfig.pyright.setup({})

		-- javascript
		lspconfig.ts_ls.setup({
			filetypes = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
			},
		})

		lspconfig.astro.setup({})

		-- vuejs
		lspconfig.volar.setup({})

		-- lua
		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using
						-- (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = {
							"vim",
							"require",
						},
					},
					workspace = {
						-- Make the server aware of Neovim runtime files
						library = vim.api.nvim_get_runtime_file("", true),
					},
					-- Do not send telemetry data containing a randomized but unique identifier
					telemetry = {
						enable = false,
					},
				},
			},
		})

		-- yaml
		lspconfig.yamlls.setup({
			settings = {
				yaml = {
					format = {
						enable = true,
					},
				},
			},
		})

		-- json
		lspconfig.jsonls.setup({})

		-- bash
		lspconfig.bashls.setup({})

		-- angular
		lspconfig.angularls.setup({})

		-- html
		lspconfig.html.setup({})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
				-- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go to declaration" })
				-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })
				vim.keymap.set("n", "grn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename symbol" })
				vim.keymap.set("n", "gra", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code action" })
				vim.keymap.set("n", "gri", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "Go to implementation" })
				vim.keymap.set("n", "grr", vim.lsp.buf.references, { buffer = ev.buf, desc = "Go to references" })
				-- vim.api.nvim_create_autocmd("BufWritePre", {
				-- 	pattern = {
				-- 		"*.rs",
				-- 		"*.lua",
				-- 		"*.js",
				-- 		"*.jsx",
				-- 		"*.ts",
				-- 		"*.tsx",
				-- 		"*.vue",
				-- 		"*.yaml",
				-- 		"*.yml",
				-- 		"*.json",
				-- 		"*.mjs",
				-- 		"*.html",
				-- 		"*.astro",
				-- 		"*.py",
				-- 	},
				-- 	callback = function()
				-- 		vim.lsp.buf.format({ async = false })
				-- 	end,
				-- })
			end,
		})
	end,
}
