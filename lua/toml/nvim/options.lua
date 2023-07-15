local M = {}

function M.apply(config)
  local options = config.nvim.options
  local nvim_state = vim.fn.stdpath("state")
  local nvim_config = vim.fn.stdpath("config")
  for option, value in pairs(options) do
    if vim.tbl_contains({ "backupdir", "spellfile" }, option) then
      value = value:gsub('${NVIM_STATE}', nvim_state)
      value = value:gsub('${NVIM_CONFIG}', nvim_config)
    end
    vim.opt[option] = value
  end
end

return M
