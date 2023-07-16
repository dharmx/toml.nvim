local M = {}

function M.apply(config)
  local options = config.nvim.options
  for option, value in pairs(options) do
    if vim.tbl_contains({ "backupdir", "spellfile" }, option) then
      value = vim.fn.expand(value)
    end
    vim.opt[option] = value
  end
end

return M
