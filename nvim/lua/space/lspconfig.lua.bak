local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "folke/neodev.nvim",
    },
  },
}

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>zz", opts)
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover({border ='rounded', max_width=80, max_height=20})<CR>", opts)
  keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keymap(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)

  -- trigger code lens
  vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
end

local function common_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return capabilities
end

function M.config()
  local wk = require("which-key")

  wk.add({
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
    -- { "<leader>lh", "<cmd>lua require('space.lspconfig').toggle_inlay_hints()<cr>", desc = "Hints" },
    { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
    { "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic" },
    { "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic" },
    -- { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
    { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
    -- ["<C-h"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature" },
  })

  local lspconfig = require("lspconfig")
  local icons = require("space.icons")

  vim.filetype.add({ extension = { templ = "templ" } })
  local servers = {
    "lua_ls",
    "cssls",
    "html",
    "ts_ls",
    "marksman",
    "bashls",
    "jsonls",
    "yamlls",
    "gopls",
    "templ",
    -- "htmx",
    "tailwindcss",
    -- "angularls",
    "clangd",
    -- "omnisharp",
    "svelte",
  }

  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
        [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
        [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
        [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
      },
    },
    virtual_text = false,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  })

  for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

  require("lspconfig.ui.windows").default_options.border = "rounded"

  for _, server in pairs(servers) do
    local opts = {
      on_attach = M.on_attach,
      capabilities = common_capabilities(),
    }

    local require_ok, settings = pcall(require, "space.lspsettings." .. server)
    if require_ok then
      opts = vim.tbl_deep_extend("force", settings, opts)
    end

    if server == "lua_ls" then
      require("neodev").setup({})
    end

    if server == "gopls" then
      opts.gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
        gofumpt = true,
      }
    end

    if server == "tailwindcss" then
      opts.tailwindcss = {
        filetypes = { "templ", "react", "html", "angular.html" },
        init_options = { userLanguages = { templ = "html" } },
      }
    end

    if server == "ts_ls" then
      local function organize_imports()
        local params = {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
          title = "",
        }
        vim.lsp.buf.execute_command(params)
      end
      opts.ts_ls = {

        capabilities = common_capabilities(),
        filetypes = { "typescript", "typescriptreact" },
        root_dir = require("lspconfig/util").root_pattern("tsconfig.json", ".git"),
        on_attach = M.on_attach,
        commands = {
          OrganizeImports = {
            organize_imports,
            description = "Organize Imports",
          },
        },
      }
    end

    lspconfig[server].setup(opts)
  end

  lspconfig.angularls.setup({
    cmd = {
      vim.fn.stdpath("data") .. "/mason/bin/ngserver",
      "--stdio",
      "--tsProbeLocations",
      "/Users/borysolenjniczak/Code/advocate-ui",
      "--ngProbeLocations",
      "/Users/borysolenjniczak/Code/advocate-ui",
    },
    root_dir = lspconfig.util.root_pattern("angular.json", "project.json"),
    filetypes = { "typescript", "angular.html" },
    on_attach = M.on_attach,
    capabilities = common_capabilities(),
  })

  -- Setup html separately
  lspconfig.html.setup({
    filetypes = { "templ", "react", "html", "angular.html" },
    on_attach = M.on_attach,
    capabilities = common_capabilities(),
  })

  -- Setup omnisharp separately
  lspconfig.omnisharp.setup({
    capabilities = common_capabilities(),
    cmd = { "dotnet", vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
    enable_import_completion = true,
    organize_imports_on_format = true,
    enable_roslyn_analyzers = true,
    root_dir = function()
      return vim.loop.cwd() -- current working directory
    end,
  })
  lspconfig.graphql.setup({
    cmd = { "graphql-lsp", "server", "--method", "stream" },
    filetypes = { "graphql", "typescript", "typescriptreact", "javascript" },
    root_dir = require("lspconfig.util").root_pattern(".git", "graphql.config.yml"),
  })

  lspconfig.intelephense.setup({
    settings = {
      intelephense = {
        stubs = {
          "bcmath",
          "bz2",
          "calendar",
          "Core",
          "curl",
          "zip",
          "zlib",
          "wordpress",
          "woocommerce",
          "acf-pro",
          "wordpress-globals",
          "wp-cli",
          "genesis",
          "polylang",
        },
        environment = {
          -- includePaths = '/home/your-user/.composer/vendor/php-stubs/' -- this line forces the composer path for the stubs in case inteliphense don't find it...
        },
        files = {
          maxSize = 5000000,
        },
      },
    },
  })
end

return M
