local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.keymapper")

local format_map = function(map)
  return {
    [map.key] = {
      map.description,
      map.method,
      buffer = map.buffer,
      silent = map.silent,
      noremap = map.noremap,
      nowait = map.nowait,
      mode = map.mode,
    },
  }
end

local format_group = function(map)
  return {
    [map.key] = {
      name = map.description,
      buffer = map.buffer,
      silent = map.silent,
      noremap = map.noremap,
      nowait = map.nowait,
      mode = map.mode,
    },
  }
end

M.format = function(map)
  local message = {
    module = "adapters/keymapper",
    func = "format",
    server = map,
  }
  logger_use_manage.debug(message)

  if map.method == nil then
    return format_group(map)
  end

  return format_map(map)
end

M.register = function(map)
  local message = {
    module = "adapters/keymapper",
    func = "register",
    server = map,
  }
  logger_use_manage.debug(message)

  local formatted = M.format(map)
  plugin.register(formatted)
end

M.register_all = function(maps)
  local message = {
    module = "adapters/keymapper",
    func = "regist_all",
    server = maps,
  }
  logger_use_manage.debug(message)

  for _, map in pairs(maps) do
    M.register(map)
  end
end

-- local maps = require("domain.maps")
-- M.regist_all(maps)

return M
