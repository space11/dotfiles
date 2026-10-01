return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "williamboman/mason.nvim",
      cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate", "MasonLog" },
      opts = { ui = { border = "rounded" } },
    },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "b0o/SchemaStore.nvim",
  },
  config = function()
    local schemastore = require("schemastore")

    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = { globals = { "vim" } },
            completion = { callSnippet = "Replace" },
          },
        },
      },
      intelephense = {
        settings = {
          intelephense = {
            files = {
              maxSize = 5000000,
            },
            environment = {
              phpVersion = "8.1.0",
            },
            stubs = {
              "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype",
              "curl", "date", "dba", "dom", "enchant", "exif", "fileinfo", "filter",
              "fpm", "ftp", "gd", "hash", "iconv", "imap", "interbase", "intl", "json",
              "ldap", "libxml", "mbstring", "mcrypt", "meta", "mssql", "mysqli", "oci8",
              "odbc", "openssl", "pcntl", "pcre", "PDO", "pdo_ibm", "pdo_mysql",
              "pdo_pgsql", "pdo_sqlite", "pgsql", "Phar", "posix", "pspell", "readline",
              "recode", "Reflection", "regex", "session", "shmop", "SimpleXML", "snmp",
              "soap", "sockets", "sodium", "SPL", "sqlite3", "standard", "superglobals",
              "sybase", "sysvmsg", "sysvsem", "sysvshm", "tidy", "tokenizer", "wddx",
              "xml", "xmlreader", "xmlrpc", "xmlwriter", "Zend OPcache", "zip", "zlib",
            },
          },
        },
      },
      ts_ls = {},
      angularls = {},
      gopls = {
        settings = {
          gopls = {
            gofumpt = false, -- canonical gofmt, not the stricter community gofumpt
            analyses = {
              unusedparams = true,
              unusedwrite = true,
              nilness = true,
              shadow = true,
              useany = true,
            },
            staticcheck = false, -- official go vet only; set true for gopls' bundled staticcheck
          },
        },
      },
      marksman = {},
      yamlls = {
        settings = {
          yaml = {
            schemaStore = { enable = false, url = "" },
            schemas = schemastore.yaml.schemas({
              -- The Atlassian-hosted bitbucket-pipelines schema has a root
              -- `$ref: "#/components/schemas/pipelines_configuration"` that yamlls
              -- can't resolve against the schema's `$id` URL (it's a docs page,
              -- not the schema itself). No working alternative URL exists
              -- (schemastore.org returns 404). Skip validation entirely for these
              -- files to silence the false-positive diagnostic.
              ignore = { "bitbucket-pipelines" },
            }),
            validate = { enable = true },
          },
        },
      },
      jsonls = {
        settings = {
          json = {
            schemas = schemastore.json.schemas(),
            validate = { enable = true },
          },
        },
      },
      dockerls = {},
      docker_compose_language_service = {},
      cssls = {},
    }

    require("mason-lspconfig").setup({
      ensure_installed = vim.tbl_keys(servers),
      automatic_installation = true,
    })
    require("mason-tool-installer").setup({
      ensure_installed = { "stylua", "prettierd", "prettier", "phpstan", "php-cs-fixer", "goimports" },
      run_on_start = true,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if ok_cmp then
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
    end

    vim.lsp.config("*", { capabilities = capabilities })
    for name, cfg in pairs(servers) do
      vim.lsp.config(name, cfg)
    end
    vim.lsp.enable(vim.tbl_keys(servers))

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
      callback = function(args)
        local buf = args.buf
        local function nmap(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = buf, silent = true, desc = desc })
        end
        nmap("gd", vim.lsp.buf.definition, "Go to definition")
        nmap("gD", vim.lsp.buf.declaration, "Go to declaration")
      end,
    })

    vim.diagnostic.config({
      virtual_text = false,
      signs = true,
      underline = false,
      update_in_insert = false,
      severity_sort = true,
      float = { border = "rounded" },
      jump = {
        on_jump = function(diagnostic, bufnr)
          if diagnostic then
            vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
          end
        end,
      },
    })
  end,
}
