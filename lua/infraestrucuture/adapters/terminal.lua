local vim = vim
local M = {}

local logger_use_manage = require("application.use_cases.logger")
local file_util = require("infraestrucuture.utils.file")
local plugin = require("infraestrucuture.plugins.terminal")
local snacks = plugin.snacks

M.open = function()
  local message = {
    module = "adapters/terminal",
    func = "open",
  }
  logger_use_manage.debug(message)

  plugin:open()
end

M.close = function()
  local message = {
    module = "adapters/terminal",
    func = "close",
  }
  logger_use_manage.debug(message)

  plugin:close()
end

M.toggle = function(options)
  local message = {
    module = "adapters/terminal",
    func = "toggle",
    options = options
  }
  logger_use_manage.debug(message)

  if options.type == 'external' then
    local terminal_command = vim.fn.getenv("TERMINAL")
    terminal_command = terminal_command or ''

    if terminal_command == '' then
      return
    end

    return vim.fn.system(terminal_command)
  end

  if options.location == 'project' then
    local path = file_util.pwd({ location = "project" })
    return vim.cmd('ToggleTerm direction=float dir=' .. path)
  end

  local path = file_util.pwd({ location = "file" })
  vim.cmd('ToggleTerm direction=float dir=' .. path)
  -- snacks.terminal(nil, { cwd = path })
end

return M
