local M = {}
local uv = vim.loop

function M.read(filename)
  local fd = assert(uv.fs_open(filename, "r", 438))
  local stat = assert(uv.fs_fstat(fd))
  local data = assert(uv.fs_read(fd, stat.size, 0))
  assert(uv.fs_close(fd))
  return data
end

return M
