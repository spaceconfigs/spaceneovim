local M = {}

local environments = require("domain.environments")
local log_levels = require("domain.log_levels")
local notification_use_case = require("application.use_cases.notification")

M.setup = function()
  return require("infrastructure.adapters.logger")
end

---@param opts { message: any, level: LogLevel }
M.log = function(opts)
  local adapter = M.setup()

  local message = opts.message
  local environment_log_levels_mapper = {
    [environments.PRODUCTION] = {
      log_levels.WARN,
      log_levels.ERROR,
      log_levels.INFO,
    },
    [environments.DEVELOPMENT] = {
      log_levels.WARN,
      log_levels.ERROR,
      log_levels.INFO,
      log_levels.DEBUG,
    },
  }

  local environment = vim.fn.getenv("NVIM_ENVIRONMENT")
  local levels = environment_log_levels_mapper[environment] or {}
  for _, level in pairs(levels) do
    if level ~= opts.level then
      goto continue
    end

    -- notification_use_case.notify({
    -- 	message = message,
    -- 	level = opts.level,
    -- })

    adapter.log({
      message = vim.inspect(message),
      level = opts.level,
    })

    ::continue::
  end
end

---@param message any
M.debug = function(message)
  M.log({ message = message, level = log_levels.DEBUG })
end

---@param message any
M.info = function(message)
  M.log({ message = message, level = log_levels.INFO })
end

---@param message any
M.warn = function(message)
  M.log({ message = message, level = log_levels.WARN })
end

---@param message any
M.error = function(message)
  M.log({ message = message, level = log_levels.ERROR })
end

return M
