local M = {}
local Util = require("toml.util")

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
  local prioritized_features = Util.sorted_keys(features)
  for _, feature in ipairs(prioritized_features) do
    if features[feature] then require("toml.nvim." .. feature).apply(Config.get()) end
  end
end

return M
