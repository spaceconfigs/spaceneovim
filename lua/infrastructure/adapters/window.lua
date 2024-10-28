local M = {}

local logger_use_case = require("application.use_cases.logger")
local plugin = require("infrastructure.plugins.window")
local maximize = plugin.maximize

local go_commands = { left = "h", right = "l", up = "k", down = "j" }

M.toggle = function()
  local message = {
    module = "adapters/window",
    func = "toggle",
  }
  logger_use_case.debug(message)

  maximize.toggle()
end

M.go = function(direction)
  local message = {
    module = "adapters/window",
    func = "go",
    direction = direction,
  }
  logger_use_case.debug(message)

  vim.cmd("wincmd " .. go_commands[direction])
end

M.move = function(direction)
  local message = {
    module = "adapters/window",
    func = "move",
    direction = direction,
  }
  logger_use_case.debug(message)

  vim.cmd("WinShift " .. direction)
end

M.move_far = function(direction)
  local message = {
    module = "adapters/window",
    func = "move_far",
    direction = direction,
  }
  logger_use_case.debug(message)

  vim.cmd("WinShift far_" .. direction)
end

M.go_to = function(number)
  local message = {
    module = "adapters/window",
    func = "go_to",
  }
  logger_use_case.debug(message)

  vim.cmd("wincmd " .. number .. " w")
end

M.close = function()
  local message = {
    module = "adapters/window",
    func = "close",
  }
  logger_use_case.debug(message)

  vim.cmd("quit")
end

M.split = function(opts)
  local message = {
    module = "adapters/window",
    func = "split",
    opts = opts,
  }
  logger_use_case.debug(message)

  local cmd = opts.type
  if opts.previous then
    cmd = cmd .. " | wincmd p"
  end

  vim.cmd(cmd)
end

M.dedicate = function()
  local message = {
    module = "adapters/window",
    func = "dedicate",
  }
  logger_use_case.debug(message)

  vim.cmd("PinBuffer")
end

return M
