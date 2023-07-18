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

function M._apply_mouse(config)
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

function M._apply_cursor(config)
  local cursor = vim.deepcopy(config.nvim.editor.cursor)
  local options = {}
  for option, enabled in pairs(cursor.options) do
    if enabled then table.insert(options, option) end
  end
  cursor.options = nil

  local parsed_options = table.concat(options, ",")
  if parsed_options ~= "" then vim.opt.cursorlineopt = parsed_options end
  for option, enabled in pairs(cursor) do vim.opt[option] = enabled end
end

local components = {
  "spacing",
  "split",
  "tui",
  "gui",
  "fold",
  "wild",
  "wrap",
  "backup",
  "undo",
  "spell"
}

function M.apply(config)
  local editor = vim.deepcopy(config.nvim.editor)
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

  for _, component in ipairs(components) do
    for key, value in pairs(editor[component]) do vim.opt[key] = value end
    editor[component] = nil
  end

  M._apply_cursor(config)
  M._apply_mouse(config)
  vim.opt.fillchars = editor.fillchars

  editor.mouse = nil
  editor.cursor = nil
  editor.line_number = nil
  editor.fillchars = nil
  -- now only the top level values remain

  editor.shell = vim.fn.expand(editor.shell)
  for key, value in pairs(editor) do vim.opt[key] = value end
end

return M
