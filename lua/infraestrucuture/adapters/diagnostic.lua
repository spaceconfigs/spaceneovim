local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.diagnostic")
local snacks = plugin.snacks

M.toggle = function()
  local message = {
    module = "adapters/diagnostic",
    func = "toggle",
  }
  logger_use_manage.debug(message)

  snacks.picker.diagnostics_buffer({ layout = { preset = "nitaicharan" } })
end

M.show = function(direction)
  local message = {
    module = "adapters/diagnostic",
    func = "show",
    direction = direction,
  }
  logger_use_manage.debug(message)

  if direction == "previous" then
    return vim.diagnostic.goto_prev()
  end

  if direction == "next" then
    return vim.diagnostic.goto_next()
  end

  snacks.picker.diagnostics({ layout = { preset = "nitaicharan" } })
end

return M
