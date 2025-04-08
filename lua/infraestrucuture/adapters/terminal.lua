local vim = vim
local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.terminal")
local snacks = plugin.snacks

M.open = function(options)
  local message = {
    module = "adapters/terminal",
    func = "open",
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

  -- snacks.terminal.toggle(nil, { interactive = true, cwd = options.path })
end

M.close = function(options)
  local message = {
    module = "adapters/terminal",
    func = "close",
    options = options
  }
  logger_use_manage.debug(message)

  -- snacks.terminal.toggle(nil, { interactive = true, cwd = options.path })
end

M.toggle = function(options)
  local message = {
    module = "adapters/terminal",
    func = "close",
    options = options
  }
  logger_use_manage.debug(message)

  vim.cmd('ToggleTerm direction=float dir=' .. options.path)
  -- snacks.terminal.toggle(nil, { interactive = true, cwd = options.path })
end

return M
