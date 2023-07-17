local M = {}

M._defaults = {
  path = vim.fn.stdpath("config") .. "/config.toml",
  directory = vim.fn.stdpath("config"),
  nvim = {
    global = {
      theme = "quiet",
      providers = { "node", "perl", "python3", "ruby" },
    },
  },
  engine = {
    strict = false,
    features = {
      global = 1,
      plugin = true,
      keymap = true,
      variables = true,
      options = true,
      editor = true,
      sign = true,
    },
  },
  log = {
    plugin = "toml",
    level = "warn",
  },
}

M._current = vim.deepcopy(M._defaults)

function M.merge(options)
  options = vim.F.if_nil(options, {})
  M._current = vim.tbl_deep_extend("keep", options, M._current)
end

function M.merge_nvim(options)
  options = vim.F.if_nil(options, {})
  M._current.nvim = vim.tbl_deep_extend("keep", options, M._current.nvim)
end

function M.extend(options)
  options = vim.F.if_nil(options, {})
  return vim.tbl_deep_extend("keep", options, M._current)
end

function M.extend_nvim(options)
  options = vim.F.if_nil(options, {})
  vim.tbl_deep_extend("keep", options, M._current.nvim)
end

function M.get() return M._current end

return M
