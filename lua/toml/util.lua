local M = {}
local U = vim.loop

function M.read(filename)
  local fd = assert(U.fs_open(filename, "r", 438))
  local stat = assert(U.fs_fstat(fd))
  local data = assert(U.fs_read(fd, stat.size, 0))
  assert(U.fs_close(fd))
  return data
end

function M.rank_map_keys(map)
  local keys = vim.tbl_keys(map)
  table.sort(keys, function(a, b)
    local type_a = type(map[a])
    local type_b = type(map[b])
    if type_a == "number" and type_b == "number" then
      return map[a] < map[b]
    elseif type_a ~= "number" and type_b ~= "number" then
      return false
    elseif type_a == "number" then
      return true
    end
    return false
  end)
  return keys
end

return M
