local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
  return require("infraestrucuture.adapters.terminal")
end

M.open = function()
  local message = {
    module = "use_cases/terminal",
    func = "open",
  }
  logger_use_case.debug(message)
  local adapter = M.setup()

  adapter.open()
end

M.close = function()
  local message = {
    module = "use_cases/terminal",
    func = "close",
  }
  logger_use_case.debug(message)
  local adapter = M.setup()

  adapter.close()
end

M.toggle = function(options)
  return function()
    local message = {
      module = "use_cases/terminal",
      func = "toggle",
      options = options
    }
    logger_use_case.debug(message)
    local adapter = M.setup()
    options = options or {}
    options.type = options.type or 'internal'
    options.location = options.location or 'file'

    adapter.toggle(options)
  end
end

return M
