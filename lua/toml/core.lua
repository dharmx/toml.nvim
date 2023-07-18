local M = {}

local Toml = require("toml.engine")
local Util = require("toml.util")

function M.parse(config)
  local tail = vim.fn.fnamemodify(config.path, ":e")
  local data = Util.read(config.path)
  assert(type(data) == "string")
  data = data:gsub("$NVIM_CONFIG", vim.fn.stdpath("config"))
  data = data:gsub("$NVIM_STATE", vim.fn.stdpath("state"))
  data = data:gsub("$NVIM_DATA", vim.fn.stdpath("data"))
  data = data:gsub("$NVIM_CACHE", vim.fn.stdpath("cache"))

  if tail == "toml" then
    return Toml.decode(data)
  elseif tail == "json" then
    ---@diagnostic disable-next-line: param-type-mismatch
    return vim.json.decode(data)
  end
  error("Only TOML and JSON filetypes are allowed.")
end

return M
