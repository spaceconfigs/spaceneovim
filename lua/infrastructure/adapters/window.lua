local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.window")
local maximize = plugin.maximize

local go_commands = { left = "h", right = "l", up = "k", down = "j" }

---@type WindowAdapter
local M = {
  toggle = function()
    maximize.toggle()
  end,

  go = function(direction)
    vim.cmd("wincmd " .. go_commands[direction])
  end,

  move = function(direction)
    vim.cmd("WinShift " .. direction)
  end,

  move_far = function(direction)
    vim.cmd("WinShift far_" .. direction)
  end,

  go_to = function(number)
    vim.cmd("wincmd " .. number .. " w")
  end,

  close = function()
    vim.cmd("quit")
  end,

  split = function(opts)
    local cmd = opts.type
    if opts.previous then
      cmd = cmd .. " | wincmd p"
    end

    vim.cmd(cmd)
  end,

  dedicate = function()
    vim.cmd("PinBuffer")
  end,
}

return make_logged("adapters/window", M)
