local M = {}
local U = vim.loop

local toml = require("toml.engine")
local Path = require("plenary.path")

function M.config_path(filetype)
  local home = vim.F.if_nil(vim.env.XDG_CONFIG_HOME, vim.fn.expand("~/.config"))
  ---@type string[]
  local paths = {
    vim.fn.stdpath("config") .. "/config.",
    home .. "/nvim.",
    home .. "/nvim/config.",
    vim.fn.expand("~/.nvim."),
  }
  for _, path in ipairs(paths) do
    if U.fs_realpath(path .. filetype) then return path .. filetype, filetype end
  end
end

function M.parse()
  local path, filetype = M.config_path("toml")
  if not path then path, filetype = M.config_path("json") end
  assert(path, "No configuration files found.")

  local data = Path:new(path):read()
  if filetype == "toml" then
    return toml.parse(data)
  end
  return vim.json.decode(data)
end

return M
