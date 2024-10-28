local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.registry").window()
local maximize = plugin.maximize

local go_commands = { left = "h", right = "l", up = "k", down = "j" }

---@type WindowPort
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

  resize = function(opts)
    local axis = opts.axis
    local delta = opts.delta
    local getter = axis == "height" and vim.api.nvim_win_get_height or vim.api.nvim_win_get_width
    local setter = axis == "height" and vim.api.nvim_win_set_height or vim.api.nvim_win_set_width

    setter(0, getter(0) + delta)
  end,

  balance = function()
    vim.cmd("wincmd =")
  end,
}

return make_logged("adapters/window", M)
