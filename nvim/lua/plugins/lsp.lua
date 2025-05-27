return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", build = ":MasonUpdate" },
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason").setup()
			-- require("mason-lspconfig").setup({
			-- 	ensure_installed = { "ts_ls" }, -- add what you use
			-- 	handlers = {
			-- 		function(server)
			-- 			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- 			require("lspconfig")[server].setup({
			-- 				capabilities = capabilities,
			-- 			})
			-- 		end,
			-- 	},
			-- })

			local function lsp_keymaps(bufnr)
				local opts = { noremap = true, silent = true }
				local keymap = vim.api.nvim_buf_set_keymap
				-- keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
				-- keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>zz", opts)
				-- keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
				-- keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
				-- keymap(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
				-- keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
				keymap(
					bufnr,
					"n",
					"K",
					"<cmd>lua vim.lsp.buf.hover({ border = 'single', max_height = 25, max_width = 120 })<CR>",
					opts
				)

				-- keymap(
				-- 	bufnr,
				-- 	"i",
				-- 	"<c-",
				-- 	vim.lsp.buf.signature_help,
				-- 	opts
				-- )

				-- Function to trigger code action
				keymap(
					bufnr,
					"v",
					"<CR>",
					"<cmd>lua vim.lsp.buf.range_code_action()<CR>",
					{ desc = "LSP Range Code Action" }
				)
				keymap(bufnr, "n", "<CR>", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "LSP Code Action" })
			end

			local on_attach = function(client, bufnr)
				-- log client name and bufnr
				print("client name: " .. client.name .. ", bufnr: " .. bufnr)
				lsp_keymaps(bufnr)

				-- if client.supports_method("textDocument/inlayHint") then
				-- 	vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				-- end
				--
				-- -- refresh codelens when buffer enters and buffer is saved
				-- -- InsertLeave TextChanged
				-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre" }, {
				-- 	buffer = bufnr,
				-- 	callback = vim.lsp.codelens.refresh,
				-- })

				-- trigger code lens
				vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
			end

			local function common_capabilities()
				-- cmp_nvim_lsp.default_capabilities() already includes standard LSP features + nvim-cmp enhancements.
				local capabilities = require("cmp_nvim_lsp").default_capabilities()
				capabilities.textDocument.completion.completionItem.snippetSupport = true
				return capabilities
			end

			-- Helper to disable tsserver if angularls is also attached
			local function disable_tsserver_if_angularls(client)
				local active_clients = vim.lsp.get_active_clients({ bufnr = 0 })
				for _, c in ipairs(active_clients) do
					if c.name == "angularls" then
						-- Disable tsserver responses
						client.server_capabilities.renameProvider = false
						client.server_capabilities.referencesProvider = false
						client.server_capabilities.definitionProvider = false
						break
					end
				end
			end

			local lspconfig = require("lspconfig")

			lspconfig.angularls.setup({
				filetypes = { "typescript", "angular.html" },
				on_attach = function(client, bufnr)
					-- Disable overlapping features in angularls if ts_ls is attached
					for _, c in ipairs(vim.lsp.get_active_clients({ bufnr = bufnr })) do
						if c.name == "ts_ls" then
							client.server_capabilities.renameProvider = false
							client.server_capabilities.referencesProvider = false
							client.server_capabilities.definitionProvider = false
							break
						end
					end

					on_attach(client, bufnr)
				end,
				capabilities = common_capabilities(),
			})

			lspconfig.ts_ls.setup({
				filetypes = { "typescript" }, -- you can remove "angular.html" if it's unnecessary
				on_attach = on_attach,
				capabilities = common_capabilities(),
			})

			-- lua_ls is started by neodev plugin...
			-- require("lspconfig").lua_ls.setup({
			-- 	on_attach = on_attach,
			-- 	capabilities = common_capabilities(),
			-- 	settings = {
			-- 		Lua = {
			-- 			diagnostics = {
			-- 				globals = { "vim" }, -- allow `vim` as a recognized global
			-- 			},
			-- 		},
			-- 	},
			-- })
		end,
	},
}

-- return {
-- 	"neovim/nvim-lspconfig",
-- 	dependencies = {
-- 		{ "williamboman/mason.nvim", build = ":MasonUpdate" },
-- 		"williamboman/mason-lspconfig.nvim",
-- 	},
-- 	config = function()
-- 		local lspconfig = require("lspconfig")
--
-- 		-- Setup Mason
-- 		require("mason").setup()
-- 		require("mason-lspconfig").setup({
-- 			automatic_installation = true,
-- 		})
--
-- 		-- Set global LSP handlers before servers attach
-- 		local border_opts = { border = "rounded" }
-- 		-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, border_opts)
-- 		-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, border_opts)
--
-- 		-- List of servers with custom settings
-- 		local servers = {
-- 			pyright = {},
-- 			ts_ls = {
-- 				filetypes = {
-- 					"javascript",
-- 					"javascriptreact",
-- 					"javascript.jsx",
-- 					"typescript",
-- 					"typescriptreact",
-- 					"typescript.tsx",
-- 				},
-- 			},
-- 			lua_ls = {
-- 				settings = {
-- 					Lua = {
-- 						runtime = { version = "LuaJIT" },
-- 						diagnostics = { globals = { "vim", "require" } },
-- 						workspace = { library = vim.api.nvim_get_runtime_file("", true) },
-- 						telemetry = { enable = false },
-- 					},
-- 				},
-- 			},
-- 			yamlls = {
-- 				settings = {
-- 					yaml = { format = { enable = true } },
-- 				},
-- 			},
-- 			jsonls = {},
-- 			bashls = {},
-- 			angularls = {},
-- 			html = {},
-- 		}
--
-- 		-- Apply each server's config
-- 		for server, config in pairs(servers) do
-- 			lspconfig[server].setup(config)
-- 		end
--
-- 		-- Optional: LSP keymaps
-- 		vim.api.nvim_create_autocmd("LspAttach", {
-- 			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
-- 			callback = function(ev)
-- 				local opts = { buffer = ev.buf, desc = "LSP: " }
-- 				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
--
-- 				local map = vim.keymap.set
-- 				map("n", "grn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = opts.desc .. "Rename" }))
-- 				map(
-- 					"n",
-- 					"gra",
-- 					vim.lsp.buf.code_action,
-- 					vim.tbl_extend("force", opts, { desc = opts.desc .. "Code Action" })
-- 				)
-- 				map(
-- 					"n",
-- 					"gri",
-- 					vim.lsp.buf.implementation,
-- 					vim.tbl_extend("force", opts, { desc = opts.desc .. "Implementation" })
-- 				)
-- 				map(
-- 					"n",
-- 					"grr",
-- 					vim.lsp.buf.references,
-- 					vim.tbl_extend("force", opts, { desc = opts.desc .. "References" })
-- 				)
--
-- 				map(
--           "n",
-- 					"K",
-- 					"<cmd>lua vim.lsp.buf.hover({ border = 'single', max_height = 25, max_width = 120 })<CR>",
-- 					opts
-- 				)
-- 			end,
-- 		})
-- 	end,
-- }

-- return {
-- 	{
-- 		"neovim/nvim-lspconfig",
-- 		dependencies = {
-- 			{ "williamboman/mason.nvim", build = ":MasonUpdate" },
-- 			"williamboman/mason-lspconfig.nvim",
-- 			"hrsh7th/cmp-nvim-lsp",
-- 		},
-- 		config = function()
-- 			require("mason").setup()
-- 			require("mason-lspconfig").setup({
-- 				ensure_installed = { "ts_ls", "angularls" },
-- 			})
--
-- 			local lspconfig = require("lspconfig")
-- 			local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
--
-- 			local function on_attach(client, bufnr)
-- 				print("LSP attached:", client.name, "on buffer", bufnr)
--
-- 				print(vim.inspect(client.server_capabilities.hoverProvider))
--
-- 				if client.name == "ts_ls" then
-- 					for _, c in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
-- 						if c.name == "angularls" then
-- 							client.server_capabilities.renameProvider = false
-- 							client.server_capabilities.referencesProvider = false
-- 							client.server_capabilities.definitionProvider = false
-- 							break
-- 						end
-- 					end
-- 				end
--
-- 				local opts = { noremap = true, silent = true, buffer = bufnr }
--
-- 				vim.keymap.set("n", "K", function()
-- 					vim.lsp.buf.hover({ border = "single", max_width = 120, max_height = 25 })
-- 				end, opts)
--
-- 				vim.keymap.set(
-- 					"n",
-- 					"<CR>",
-- 					vim.lsp.buf.code_action,
-- 					vim.tbl_extend("force", opts, { desc = "LSP Code Action" })
-- 				)
--
-- 				vim.keymap.set("v", "<CR>", function()
-- 					vim.lsp.buf.code_action()
-- 				end, vim.tbl_extend("force", opts, { desc = "LSP Range Code Action" }))
-- 			end
--
-- 			local servers = {
-- 				angularls = {
-- 					filetypes = { "typescript", "html", "angular.html" },
-- 					on_attach = on_attach,
-- 					capabilities = cmp_capabilities,
-- 				},
-- 				ts_ls = {
-- 					filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
-- 					on_attach = on_attach,
-- 					capabilities = cmp_capabilities,
-- 				},
-- 			}
--
-- 			for server, opts in pairs(servers) do
-- 				lspconfig[server].setup(opts)
-- 			end
-- 		end,
-- 	},
-- }
