local M = {}

function M.apply(config)
  local variables = config.nvim.variables
  for name, value in pairs(variables) do vim.g[name] = value end
end

return M
