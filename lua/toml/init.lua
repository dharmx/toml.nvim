local M = {}

function M.setup(options)
  local Config = require("toml.config")
  Config.merge(options)
  Config.merge_nvim(require("toml.core").parse())
  require("toml.nvim.global").apply(Config.get())
  require("toml.nvim.keymap").apply(Config.get())
  require("toml.nvim.variables").apply(Config.get())
  require("toml.nvim.options").apply(Config.get())
end

return M
