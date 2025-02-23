local M = {}

local logger_use_case = require("application.use_cases.logger")
local file_util = require("infraestrucuture.utils.file")

vim.g.terminal_opened = false

M.setup = function()
  return require("infraestrucuture.adapters.terminal")
end

M.open = function(options)
  local message = {
    module = "use_cases/terminal",
    func = "open",
  }
  logger_use_case.debug(message)
  local adapter = M.setup()

  local path = file_util.pwd({ location = "file" })
  if options.location == 'project' then
    path = file_util.pwd({ location = "project" })
  end

  options = options or {}
  options.type = options.type or 'internal'
  options.location = options.location or 'file'
  options.path = path


  adapter.open(options)
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
    options.path = vim.g.terminal_path

    local path = file_util.pwd({ location = "file" })
    if options.location == 'project' then
      path = file_util.pwd({ location = "project" })
    end

    vim.g.terminal_opened = vim.g.terminal_opened == false

    if vim.g.terminal_opened then
      vim.g.terminal_path = path
      options.path = path
      return adapter.open(options)
    end

    adapter.close(options)
  end
end

return M
