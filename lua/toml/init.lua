local M = {}

function M.setup(options)
  vim.env.NVIM_CONFIG = vim.fn.stdpath("config")
  vim.env.NVIM_STATE = vim.fn.stdpath("state")
  vim.env.NVIM_DATA = vim.fn.stdpath("data")
  vim.env.NVIM_CACHE = vim.fn.stdpath("cache")

  local Config = require("toml.config")
  Config.merge(options)
  require("toml.engine").strict = Config.get().engine.strict
  Config.merge_nvim(require("toml.core").parse(Config.get()))

  local features = Config.get().engine.features
  for feature, enabled in pairs(features) do
    if enabled then require("toml.nvim." .. feature).apply(Config.get()) end
  end
end

return M
