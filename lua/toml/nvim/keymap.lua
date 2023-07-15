local M = {}

function M.apply(config)
  local keymap = config.nvim.keymap
  for mode, maps in pairs(keymap) do
    if type(maps) == "table" then
      for key, action in pairs(maps) do
        vim.keymap.set(mode:sub(1, 1), key, action, {
          remap = keymap.remap,
          silent = keymap.silent,
        })
      end
    end
  end
end

return M
