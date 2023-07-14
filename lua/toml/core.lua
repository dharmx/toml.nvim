local M = {}

local toml = require("toml.engine")
local Path = require("plenary.path")
local Config = require("toml.config").get()

function M.parse()
  local tail = vim.fn.fnamemodify(Config.path, ":e")
  local path = Path:new(Config.path)
  local data = path:read()
  if tail == "toml" then
    return toml.decode(data)
  elseif tail == "json" then
    return vim.json.decode(data)
  end
  error("Only TOML and JSON filetypes are allowed.")
end

return M
