local M = {}

function M.apply(config)
  local global = config.nvim.global
  vim.g.mapleader = global.leader
  vim.cmd.colorscheme(global.theme)
  for _, provider in ipairs(global.providers) do
    vim.g["loaded_" .. provider .. "_provider"] = 0
  end
end

return M
