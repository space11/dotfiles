local function root()
  return require("util.root")()
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  init = function()
    vim.api.nvim_create_user_command("NewKeysList", function()
      require("util.new_keys").show()
    end, { desc = "Show the new nvim 0.12 keybindings" })
  end,
  ---@type snacks.Config
  opts = {
    picker = {
      ui_select = true,
      layout = {
        preset = "vertical",
        layout = {
          width = 0.85,
        },
      },
      sources = {
        grep = {
          args = { "--trim" },
        },
        grep_word = {
          args = { "--trim" },
        },
      },
    },
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = [[
███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
        keys = {
          { key = "f", desc = "Find file", action = function() Snacks.picker.files() end },
          { key = "r", desc = "Recent files", action = function() Snacks.picker.recent() end },
          { key = "g", desc = "Live grep", action = function() Snacks.picker.grep() end },
          { key = "n", desc = "New file", action = ":ene" },
          { key = "e", desc = "File explorer", action = ":Oil" },
          { key = "l", desc = "Lazy", action = ":Lazy" },
          { key = "m", desc = "Mason", action = ":Mason" },
          { key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { footer = "nvim " .. tostring(vim.version()) },
        require("util.new_keys").dashboard_section(),
      },
    },
    notifier = { enabled = false },
    statuscolumn = { enabled = false },
    indent = { enabled = false },
    scope = { enabled = false },
    scroll = { enabled = false },
  },
  keys = {
    {
      "<leader>ff",
      function() Snacks.picker.files({ cwd = root() }) end,
      desc = "Find files (project root)",
    },
    {
      "<leader>fF",
      function() Snacks.picker.files() end,
      desc = "Find files (cwd)",
    },
    {
      "<leader>fg",
      function() Snacks.picker.grep({ cwd = root() }) end,
      desc = "Live grep (project root)",
    },
    {
      "<leader>fG",
      function() Snacks.picker.grep() end,
      desc = "Live grep (cwd)",
    },
    {
      "<leader>fb",
      function() Snacks.picker.buffers() end,
      desc = "Buffers",
    },
    {
      "<leader>fh",
      function() Snacks.picker.help() end,
      desc = "Help tags",
    },
    {
      "<leader>fr",
      function() Snacks.picker.recent() end,
      desc = "Recent files",
    },
    {
      "<leader>fp",
      function() Snacks.picker.projects() end,
      desc = "Projects",
    },
    {
      "<leader>fd",
      function() Snacks.picker.diagnostics() end,
      desc = "Diagnostics",
    },
    {
      "<leader>fs",
      function() Snacks.picker.lsp_symbols() end,
      desc = "Document symbols",
    },
    {
      "<leader>fl",
      function() Snacks.picker.resume() end,
      desc = "Resume last picker",
    },
    {
      "<leader>fw",
      function() Snacks.picker.grep_word({ cwd = root() }) end,
      desc = "Grep word under cursor (project root)",
    },
    {
      "<leader>fW",
      mode = "v",
      function() Snacks.picker.grep_word({ cwd = root() }) end,
      desc = "Grep visual selection (project root)",
    },
  },
}
