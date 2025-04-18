local M = {
  "nvim-lualine/lualine.nvim",
}

function M.config()
  require("lualine").setup({
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      ignore_focus = { "NvimTree" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = { "diagnostics" },
      lualine_x = { "filetype" },
      lualine_y = { "progress" },
      lualine_z = {
        function()
          return vim.wo.wrap and "󰖶 WRAP" or "󰜺 NO-WRAP"
        end,
      },
    },
    extensions = { "quickfix", "man", "fugitive" },
  })
end

return M
