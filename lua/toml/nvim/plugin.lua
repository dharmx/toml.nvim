local M = {}

local Toml = require("toml.engine")
local Util = require("toml.util")

local keys_with = {
  only_factory = {
    "enabled",
    "cond",
    "opts",
    "keys",
    "event",
    "cmd",
    "ft",
  },
  factory = {
    "init",
    "config",
    "build",
  },
}


function M._parse_lazy_plugins(config)
  local plugins = Toml.decode(Util.read(config.directory .. "/plugin.toml")).spec
  local factory = config.factory
  local parsed = {}

  for _, plugin in ipairs(plugins) do
    local copy = vim.deepcopy(plugin)
    table.insert(copy, 1, plugin.plugin)
    copy.plugin = nil

    for _, key in ipairs(keys_with.factory) do
      if plugin[key] and type(plugin[key]) == "string" then
        if plugin[key] == config.factory.mark then
          copy[key] = factory.contents.lazy[plugin.plugin][key]
        else
          copy[key] = function() require(plugin[key]) end
        end
      end
    end

    for _, key in ipairs(keys_with.only_factory) do
      if plugin[key] == config.factory.mark then
        copy[key] = factory.contents.lazy[plugin.plugin][key]
      end
    end
    table.insert(parsed, copy)
  end
  return parsed
end

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
  lazy.spec = M._parse_lazy_plugins(config)
  require("lazy").setup(lazy)
end

function M._setup_engine(config)
  local engine = config.nvim.plugin.engine
  if engine.use == "lazy" then M._setup_lazy(config) end
end

function M.apply(config) M._setup_engine(config) end

return M
