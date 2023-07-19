local M = {}
local Util = require("toml.util")
local Log = require("toml.config")._log

function M.apply(config)
  local feats = config.engine.features
  -- features needs to be loaded by order sometimes
  -- like: lazy.nvim needs leader to be set before it is loaded
  local ranked_feats = Util.rank_map_keys(feats)
  for _, feat in ipairs(ranked_feats) do
    if feats[feat] then
      Log.debug("nvim.apply(): Applying " .. feat .. " feature.")
      require("toml.nvim." .. feat).apply(config)
    end
  end
end

return M
