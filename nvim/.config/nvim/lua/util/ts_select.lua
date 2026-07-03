-- Treesitter-based incremental selection. nvim-treesitter's `main` branch dropped
-- the bundled `incremental_selection` module, so we rebuild a minimal version here.
-- Mirrors the old config's behaviour: same key seeds and expands, separate key shrinks.
--
-- Behaviour:
--   * In normal mode → seed the stack with the node at the cursor, select it.
--   * In visual mode → expand selection to the parent node of the top of stack.
--   * Shrink → pop the top of the stack, re-select the previous node.
--
-- The stack lives in a module-level table keyed by bufnr (TSNode is userdata and
-- can't go into a buffer-var). A BufDelete autocmd clears the entry so stacks
-- don't accumulate across the session.

local M = {}

---@type table<integer, userdata[]>
local stacks = {}

local function get_stack(bufnr)
  if stacks[bufnr] == nil then
    stacks[bufnr] = {}
  end
  return stacks[bufnr]
end

local function select_range(start_row, start_col, end_row, end_col)
  -- If we're already in any visual mode, `normal! v` would toggle it OFF — exit
  -- first so the subsequent `normal! v` reliably re-enters visual mode.
  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" or mode == "\22" then
    vim.cmd("normal! \27") -- <Esc>
  end

  vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })
  vim.cmd("normal! v")
  local end_col_fixed = end_col > 0 and end_col - 1 or 0
  vim.api.nvim_win_set_cursor(0, { end_row + 1, end_col_fixed })
end

function M.expand()
  local bufnr = vim.api.nvim_get_current_buf()
  local mode = vim.fn.mode()

  if mode ~= "v" and mode ~= "V" then
    local node = vim.treesitter.get_node()
    if node == nil then
      return
    end
    stacks[bufnr] = { node }
    select_range(node:range())
    return
  end

  local stack = get_stack(bufnr)
  local current = stack[#stack]
  if current == nil then
    local node = vim.treesitter.get_node()
    if node == nil then
      return
    end
    stacks[bufnr] = { node }
    select_range(node:range())
    return
  end

  local parent = current:parent()
  if parent == nil then
    return
  end
  table.insert(stack, parent)
  select_range(parent:range())
end

function M.shrink()
  local bufnr = vim.api.nvim_get_current_buf()
  local stack = get_stack(bufnr)
  if #stack <= 1 then
    return
  end
  table.remove(stack)
  local node = stack[#stack]
  if node ~= nil then
    select_range(node:range())
  end
end

vim.api.nvim_create_autocmd("BufDelete", {
  group = vim.api.nvim_create_augroup("user_ts_select_cleanup", { clear = true }),
  callback = function(args)
    stacks[args.buf] = nil
  end,
})

return M
