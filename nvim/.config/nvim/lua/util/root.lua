local markers = {
  ".git",
  "package.json",
  "composer.json",
  "tsconfig.json",
  "angular.json",
  "nx.json",
  "pyproject.toml",
  "Cargo.toml",
  "go.mod",
  "Makefile",
}

return function()
  local buf = vim.api.nvim_buf_get_name(0)
  local start = (buf ~= "" and vim.fn.filereadable(buf) == 1) and buf or vim.uv.cwd()
  local found = vim.fs.root(start, markers)
  return found or vim.uv.cwd()
end
