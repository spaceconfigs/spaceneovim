local vim = vim
local log_levels = require("domain.log_levels")
local plugin = require("infrastructure.plugins.registry").notification()
local snacks = plugin.snacks

---@type NotificationPort
local M
M = {
  notify = function(opts)
    local level = opts.level
    local message = opts.message

    local levels_mapper = {
      [log_levels.DEBUG] = M.debug,
      [log_levels.INFO] = M.info,
      [log_levels.WARN] = M.warn,
      [log_levels.ERROR] = M.error,
    }

    levels_mapper[level]({ message = message })
  end,
  dismiss = function()
    snacks.notifier.hide()
  end,
  list = function()
    snacks.picker.notifications()
  end,
  debug = function(opts)
    snacks.notify.info(type(opts.message) == "string" and opts.message or vim.inspect(opts.message))
  end,
  info = function(opts)
    snacks.notify.info(type(opts.message) == "string" and opts.message or vim.inspect(opts.message))
  end,
  warn = function(opts)
    snacks.notify.warn(type(opts.message) == "string" and opts.message or vim.inspect(opts.message))
  end,
  error = function(opts)
    snacks.notify.error(type(opts.message) == "string" and opts.message or vim.inspect(opts.message))
  end,
}

return M
