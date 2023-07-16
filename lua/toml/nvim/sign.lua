local M = {}
local Path = require("plenary.path")

function M.apply_diagnostic(config)
  local diagnostic = vim.deepcopy(config.nvim.sign.diagnostic)
  diagnostic.lightbulb = config.nvim.sign.lightbulb
  for _, sign in pairs(diagnostic) do
    if type(sign) == "table" then
      vim.fn.sign_define(sign.name, {
        icon = sign.icon,
        linehl = sign.linehl,
        numhl = sign.numhl,
        text = sign.text,
        texthl = sign.texthl,
        culhl = sign.culhl,
      })
    end
  end
end

function M.apply(config)
  local sign = config.nvim.sign
  if sign.signcolumn then vim.o.signcolumn = sign.signcolumn end
  M.apply_diagnostic(config)
end

return M
