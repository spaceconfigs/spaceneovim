---@type LoggerUseCase
local M

local environments = require("domain.environments")
local log_levels = require("domain.log_levels")
local notification_usecase = require("application.usecases.notification")

M = {
  setup = function()
    return require("application.ports.adapter_registry").logger()
  end,

  setup_lsp_log = function()
    local adapter = M.setup()

    local environment_mapper = {
      [environments.PRODUCTION] = log_levels.OFF,
      [environments.DEVELOPMENT] = log_levels.DEBUG,
    }

    local environment = adapter.environment()
    adapter.set_lsp_log_level(environment_mapper[environment] or log_levels.OFF)
  end,

  log = function(opts)
    local adapter = M.setup()

    local message = opts.message
    local environment_mapper = {
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

    local environment = adapter.environment()
    local levels = environment_mapper[environment] or {}
    for _, level in pairs(levels) do
      if level ~= opts.level then
        goto continue
      end

      -- notification_usecase.notify({
      -- 	message = message,
      -- 	level = opts.level,
      -- })

      adapter.log({
        message = adapter.serialize(message),
        level = opts.level,
      })

      ::continue::
    end
  end,

  debug = function(message)
    M.log({ message = message, level = log_levels.DEBUG })
  end,

  info = function(message)
    M.log({ message = message, level = log_levels.INFO })
  end,

  warn = function(message)
    M.log({ message = message, level = log_levels.WARN })
  end,

  error = function(message)
    M.log({ message = message, level = log_levels.ERROR })
  end,
}

return M
