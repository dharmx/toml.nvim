local M = {}

function M.setup(options)
  local Config = require("toml.config")
  Config.merge(options)
  require("toml.engine").strict = Config.get().engine.strict
  Config.merge_nvim(require("toml.core").parse())

  local features = Config.get().engine.features
  for feature, enabled in pairs(features) do
    if enabled then require("toml.nvim." .. feature).apply(Config.get()) end
  end
end

return M
