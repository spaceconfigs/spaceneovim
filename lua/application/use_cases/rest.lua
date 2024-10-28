local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
  return require("infrastructure.adapters.rest")
end

M.open = function()
  local message = {
    module = "use_cases/rest",
    func = "open",
  }
  logger_use_case.debug(message)
  local adapter = M.setup()

  adapter.open()
end

M.send = function()
  local message = {
    module = "use_cases/rest",
    func = "send",
  }
  logger_use_case.debug(message)
  local adapter = M.setup()

  adapter.send()
end

M.replay = function()
  local message = {
    module = "use_cases/rest",
    func = "replay",
  }
  logger_use_case.debug(message)
  local adapter = M.setup()

  adapter.replay()
end

return M
