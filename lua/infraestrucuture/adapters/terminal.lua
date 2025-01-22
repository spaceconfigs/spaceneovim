local vim = vim
local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.terminal")

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

  vim.cmd('ToggleTerm dir=git_dir')
end

M.toggle_buffer_dir = function()
  local message = {
    module = "adapters/terminal",
    func = "toggle_buffer_dir",
  }
  logger_use_manage.debug(message)
  local buffer = vim.fn.expand("%:p:h")

  vim.cmd('ToggleTerm' .. ' dir=' .. buffer)
end

return M
