local M = {}

local mouse_mode = {
  normal = "n",
  insert = "i",
  visual = "v",
  cmdline = "c",
  help = "h",
  previous = "a",
  prompt = "r",
}

function M.apply_mouse(config)
  local mouse = vim.deepcopy(config.nvim.editor.mouse)
  if mouse.enabled then
    mouse.enabled = nil
    local options = {}
    for option, enabled in pairs(mouse) do
      if enabled then table.insert(options, mouse_mode[option]) end
    end
    vim.o.mouse = table.concat(options)
  end
end

function M.apply_cursor(config)
  local cursor = vim.deepcopy(config.nvim.editor.cursor)
  local options = {}
  for option, enabled in pairs(cursor.options) do
    if enabled then table.insert(options, option) end
  end
  cursor.options = nil
  local parsed_options = table.concat(options, ",")
  if parsed_options ~= "" then vim.o.cursorlineopt = parsed_options end
  for option, enabled in pairs(cursor) do
    vim.o[option] = enabled
  end
end

function M.apply(config)
  local editor = config.nvim.editor
  if editor.line_number == "absolute" then
    vim.o.number = true
    vim.o.relativenumber = false
  elseif editor.line_number == "relative" then
    vim.o.relativenumber = true
    vim.o.number = false
  else
    vim.o.relativenumber = false
    vim.o.number = false
  end
  if editor.scrolloff then vim.o.scrolloff = editor.scrolloff end
  if editor.sidescrolloff then vim.o.sidescrolloff = editor.sidescrolloff end
  if editor.shell then vim.o.shell = vim.fn.expand(editor.shell) end
  vim.opt.fillchars = config.nvim.editor.fillchars
  M.apply_mouse(config)
  M.apply_cursor(config)
end

return M
