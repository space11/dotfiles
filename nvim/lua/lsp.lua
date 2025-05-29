-- Ensure required plugins are loaded
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		-- "lua_ls",
		"ts_ls",
		"angularls",
		"yamlls",
		"gopls",
		"cssls",
		"html",
		"bashls",
	},
})

-- Default on_attach function
local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr, noremap = true, silent = true }

	-- General LSP mappings

	local wk = require("which-key")
	wk.register({
		{ "gr", group = "LSP" },
	})
	local keymap = vim.keymap.set
	keymap("n", "grr", vim.lsp.buf.rename, { desc = "[r]ename symbol", unpack(opts) })
	keymap("n", "gra", vim.lsp.buf.code_action, { desc = "Code Action", unpack(opts) })
	keymap("n", "grd", vim.lsp.buf.definition, { desc = "Go to [d]efinition", unpack(opts) })
	keymap("n", "grD", vim.lsp.buf.declaration, { desc = "Go to [D]eclaration", unpack(opts) })
	keymap("n", "gri", vim.lsp.buf.implementation, { desc = "Go to [i]mplementation", unpack(opts) })
	keymap("n", "grt", vim.lsp.buf.type_definition, { desc = "Type Defini[t]ion", unpack(opts) })
	keymap("n", "grf", vim.lsp.buf.format, { desc = "[f]ormat Document", unpack(opts) })
	keymap(
		"n",
		"K",
		"<cmd>lua vim.lsp.buf.hover({ border = 'single', max_height = 25, max_width = 120 })<CR>",
		{ desc = "Hover", unpack(opts) }
	)
end

-- Common capabilities (for autocompletion, etc.)
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_nvim_lsp then
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
end

-- Setup LSP servers
local lspconfig = require("lspconfig")

-- Lua
require("lazydev").setup()
-- disables lua_ls because lazydev
-- lspconfig.lua_ls.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	settings = {
-- 		Lua = {
-- 			workspace = { checkThirdParty = false },
-- 			telemetry = { enable = false },
-- 		},
-- 	},
-- })

-- TypeScript/JavaScript
lspconfig.ts_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
})

-- Angular
lspconfig.angularls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "typescript", "html", "typescriptreact" },
})

-- YAML
lspconfig.yamlls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "yaml", "yml" },
})

-- Go
lspconfig.gopls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
})

-- CSS/SCSS
lspconfig.cssls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "css", "scss", "less" },
})

-- HTML
lspconfig.html.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "html" },
})

-- Bash
lspconfig.bashls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "sh", "bash", "zsh" },
})

-- return {
-- 	{
-- 		"neovim/nvim-lspconfig",
-- 		dependencies = {
-- 			{ "williamboman/mason.nvim", build = ":MasonUpdate" },
-- 			"williamboman/mason-lspconfig.nvim",
-- 		},
-- 		config = function()
-- 			require("mason").setup()
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
-- 				-- keymap(
-- 				-- 	bufnr,
-- 				-- 	"i",
-- 				-- 	"<c-",
-- 				-- 	vim.lsp.buf.signature_help,
-- 				-- 	opts
-- 				-- )
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
