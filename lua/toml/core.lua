local M = {}

local toml = require("toml.engine")
local util = require("toml.util")

function M.parse(config)
  local tail = vim.fn.fnamemodify(config.path, ":e")
  local data = util.read(config.path)
  if tail == "toml" then
    return toml.decode(data)
  elseif tail == "json" then
    ---@diagnostic disable-next-line: param-type-mismatch
    return vim.json.decode(data)
  end
  error("Only TOML and JSON filetypes are allowed.")
end

return M
