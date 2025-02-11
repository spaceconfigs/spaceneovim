local vim = vim
local M = {}

local log_levels = require("domain.log_levels")
local plugin = require("infraestrucuture.plugins.notification")
local snacks = plugin.snacks

M.notify = function(opts)
  local level = opts.level
  local message = opts.message

  local levels_mapper = {
    [log_levels.DEBUG] = M.debug,
    [log_levels.INFO] = M.info,
    [log_levels.WARN] = M.warn,
    [log_levels.ERROR] = M.error,
  }

  levels_mapper[level]({ message = message })
end

M.dismiss = function()
  snacks.notifier.hide()
end

M.list = function()
  snacks.picker.notifications({ layout = { preset = "nitaicharan" } })
end

M.debug = function(opts)
  snacks.notify.info(opts.message)
end

M.info = function(opts)
  snacks.notify.info(opts.message)
end

M.warn = function(opts)
  snacks.notify.warn(opts.message)
end

M.error = function(opts)
  snacks.notify.error(opts.message)
end

return M
