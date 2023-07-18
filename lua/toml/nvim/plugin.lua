local M = {}

function M._setup_lazy(config)
  local lazy = config.nvim.plugin.engine.lazy
  lazy.dev.path = vim.fn.expand(lazy.dev.path)
  lazy.root = vim.fn.expand(lazy.root)
  lazy.performance.cache.path = vim.fn.expand(lazy.performance.cache.path)
  lazy.readme.root = vim.fn.expand(lazy.readme.root)
  lazy.lockfile = vim.fn.expand(lazy.lockfile)

  local lazypath = lazy.root .. "/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=" .. config.nvim.plugin.engine.branch,
      lazypath,
    })
  end
  vim.opt.runtimepath:prepend(lazypath)
  require("lazy").setup(lazy)
end

function M._setup_engine(config)
  local engine = config.nvim.plugin.engine
  if engine.use == "lazy" then M._setup_lazy(config) end
end

function M.apply(config)
  M._setup_engine(config)
end

return M
