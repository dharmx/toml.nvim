local M = {}

M._defaults = {
  log = {
    plugin = "track",
    level = "warn",
  },
}

M._current = vim.deepcopy(M._defaults)

function M.merge(options)
  options = vim.F.if_nil(options, {})
  M._current = vim.tbl_deep_extend("keep", options, M._current)
end

function M.extend(options) return vim.tbl_deep_extend("keep", options, M._current) end

function M.get() return M._current end

return M
