local M = {}

local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.window")
local maximize = plugin.maximize

local go_commands = { left = "h", right = "l", up = "k", down = "j" }

M.toggle = function()
  maximize.toggle()
end

M.go = function(direction)
  vim.cmd("wincmd " .. go_commands[direction])
end

M.move = function(direction)
  vim.cmd("WinShift " .. direction)
end

M.move_far = function(direction)
  vim.cmd("WinShift far_" .. direction)
end

M.go_to = function(number)
  vim.cmd("wincmd " .. number .. " w")
end

M.close = function()
  vim.cmd("quit")
end

M.split = function(opts)
  local cmd = opts.type
  if opts.previous then
    cmd = cmd .. " | wincmd p"
  end

  vim.cmd(cmd)
end

M.dedicate = function()
  vim.cmd("PinBuffer")
end

return make_logged("adapters/window", M)
