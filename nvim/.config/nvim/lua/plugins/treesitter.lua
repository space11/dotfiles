local ensure_parsers = {
  "lua",
  "vim",
  "vimdoc",
  "bash",
  "json",
  "yaml",
  "toml",
  "markdown",
  "markdown_inline",
  "html",
  "css",
  "scss",
  "javascript",
  "typescript",
  "tsx",
  "angular",
  "php",
  "phpdoc",
  "dockerfile",
  "git_config",
  "gitcommit",
  "gitignore",
  "diff",
  "regex",
  "sql",
  "go",
  "gomod",
  "gosum",
  "gowork",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      vim.opt.runtimepath:prepend(vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/runtime")

      require("nvim-treesitter").setup({})

      local installed = require("nvim-treesitter.config").get_installed()
      local have = {}
      for _, name in ipairs(installed) do
        have[name] = true
      end
      local missing = {}
      for _, name in ipairs(ensure_parsers) do
        if not have[name] then
          table.insert(missing, name)
        end
      end
      if #missing > 0 then
        require("nvim-treesitter").install(missing)
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
          if not lang then
            return
          end
          if not pcall(vim.treesitter.start, ev.buf, lang) then
            return
          end
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          vim.wo[0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({})

      local select = require("nvim-treesitter-textobjects.select")
      local pairs_map = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      }
      for lhs, capture in pairs(pairs_map) do
        vim.keymap.set({ "x", "o" }, lhs, function()
          select.select_textobject(capture, "textobjects")
        end, { desc = "Textobject " .. capture })
      end
    end,
  },
}
