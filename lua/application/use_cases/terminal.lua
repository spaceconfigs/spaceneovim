local M = {}

local logger_use_case = require("application.use_cases.logger")
local file_util = require("infraestrucuture.utils.file")

vim.g.terminal_opened = false

M.setup = function()
  return require("infraestrucuture.adapters.terminal")
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
    options.path = file_util.pwd({ location = "file" })

    if options.location == 'project' then
      options.path = file_util.pwd({ location = "project" })
    end

    adapter.toggle(options)
  end
end

return M
