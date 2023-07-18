local M = {}
local Util = require("toml.util")

function M.setup(options)
  local Config = require("toml.config")
  Config.merge(options)
  require("toml.engine").strict = Config.get().engine.strict
  Config.merge_nvim(require("toml.core").parse(Config.get()))
  -- anything inside NVIM_CONFIG/toml can be now required
  package.path = string.format("%s;%s/?.lua", package.path, Config.get().directory)
  Config.merge({
    factory = {
      contents = require("factory")
    }
  })

  local feats = Config.get().engine.features
  -- features needs to be loaded by order sometimes
  -- like: lazy.nvim needs leader to be set before it is loaded
  local ranked_feats = Util.rank_map_keys(feats)
  for _, feat in ipairs(ranked_feats) do
    if feats[feat] then require("toml.nvim." .. feat).apply(Config.get()) end
  end
end

return M
