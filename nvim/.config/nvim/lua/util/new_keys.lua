-- TEMP: cheat sheet for the native nvim 0.12 keys, shown on the start screen and by :NewKeysList.
-- Once learned, delete this file and the two `util.new_keys` references in plugins/snacks.lua.

local M = {}

local rows = {
  { "grr", "References", "was gr" },
  { "gri", "Implementation", "was gi" },
  { "gra", "Code action", "was <leader>la" },
  { "grn", "Rename symbol", "was <leader>lr" },
  { "<C-w>d", "Line diagnostics", "was <leader>ld" },
  { "grt", "Type definition", "new" },
  { "grx", "Run codelens", "new" },
  { "gO", "Document symbols", "new" },
  { "[D ]D", "First / last diagnostic", "new" },
  { "an in", "Grow / shrink selection", "visual" },
  { "]n [n", "Next / prev node", "visual" },
  { "]N [N", "Next / prev sibling", "visual" },
  { "gi", "Back to last insert", "vim default" },
  { ":Undotree", "Undo history tree", "new" },
  { ":DiffTool", "Diff files or dirs", "new" },
}

local key_width, desc_width = 12, 26

function M.dashboard_section()
  local items = { pane = 2, { title = "New keybindings", padding = 1 } }
  for _, row in ipairs(rows) do
    table.insert(items, {
      text = {
        { row[1], hl = "key", width = key_width },
        { row[2], hl = "desc", width = desc_width },
        { row[3], hl = "dir" },
      },
    })
  end
  return items
end

function M.show()
  local lines, width = {}, 0
  for _, row in ipairs(rows) do
    local line = string.format(" %-" .. key_width .. "s%-" .. desc_width .. "s%s ", row[1], row[2], row[3])
    table.insert(lines, line)
    width = math.max(width, #line)
  end

  local win = Snacks.win({
    text = lines,
    width = width,
    height = #lines,
    border = "rounded",
    title = " New keybindings ",
    keys = { q = "close", ["<Esc>"] = "close" },
  })

  local ns = vim.api.nvim_create_namespace("user_new_keys")
  for i, row in ipairs(rows) do
    local desc_col = 1 + key_width
    local note_col = desc_col + desc_width
    vim.api.nvim_buf_set_extmark(win.buf, ns, i - 1, 1, { end_col = 1 + #row[1], hl_group = "SnacksDashboardKey" })
    vim.api.nvim_buf_set_extmark(win.buf, ns, i - 1, desc_col, { end_col = desc_col + #row[2], hl_group = "SnacksDashboardDesc" })
    vim.api.nvim_buf_set_extmark(win.buf, ns, i - 1, note_col, { end_col = note_col + #row[3], hl_group = "SnacksDashboardDir" })
  end
  vim.bo[win.buf].modifiable = false
end

return M
