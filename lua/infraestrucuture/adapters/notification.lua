local vim = vim
local M = {}

local log_levels = require("domain.log_levels")
local plugin = require("infraestrucuture.plugins.notification")
local notification = plugin.notify
local snacks = plugin.snacks

vim.opt.termguicolors = true

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
  notification.dismiss({ pending = true, silent = true })
end

M.list = function()
  snacks.picker.notifications({ layout = { preset = "nitaicharan" } })
end

M.debug = function(opts)
  notification.notify(opts.message, log_levels.DEBUG)
end

M.info = function(opts)
  notification.notify(opts.message, log_levels.INFO)
end

M.warn = function(opts)
  notification.notify(opts.message, log_levels.WARN)
end

M.error = function(opts)
  notification.notify(opts.message, log_levels.ERROR)
end

return M
