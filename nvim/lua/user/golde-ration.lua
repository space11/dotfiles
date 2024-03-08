local M = {
  "dm1try/golden_size",
  event = "VeryLazy",
}
-- Disable automatic resizing for specific windows
local function ignore_by_buftype(types)
  local buftype = vim.api.nvim_buf_get_option(0, "buftype")
  for _, type in pairs(types) do
    if type == buftype then
      return 1
    end
  end
end

function M.config()
  local golden_size = require "golden_size"
  golden_size.set_ignore_callbacks {
    { ignore_by_buftype, { "terminal", "quickfix", "nerdtree" } },
    { golden_size.ignore_float_windows }, -- default one, ignore float windows
    { golden_size.ignore_by_window_flag }, -- default one, ignore windows with w:ignore_gold_size=1
  }
end
return M
