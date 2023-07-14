if vim.version().minor < 8 then
  vim.notify("toml.nvim requires at least nvim 0.8.0.")
  return
end

if vim.g.loaded_toml == 1 then return end
vim.g.loaded_toml = 1
