local vim = vim
local M = {}

M.setup = function()
  return require("infrastructure.adapters.window")
end

M.toggle = function()
  local adapter = M.setup()

  adapter.toggle()
end

M.go = function(direction)
  local adapter = M.setup()

  adapter.go(direction)
end

M.move = function(direction)
  local adapter = M.setup()

  adapter.move(direction)
end

M.move_far = function(direction)
  local adapter = M.setup()

  adapter.move_far(direction)
end

M.resize = function(opts)
  local axis = opts.axis
  local delta = opts.delta
  local getter = axis == "height" and vim.api.nvim_win_get_height or vim.api.nvim_win_get_width
  local setter = axis == "height" and vim.api.nvim_win_set_height or vim.api.nvim_win_set_width

  setter(0, getter(0) + delta)
end

M.balance_area = function()
  vim.cmd("wincmd =")
end

M.go_to = function(number)
  local adapter = M.setup()

  adapter.go_to(number)
end

M.close = function()
  local adapter = M.setup()

  adapter.close()
end

M.split = function(opts)
  local adapter = M.setup()

  adapter.split(opts)
end

M.dedicate = function()
  local adapter = M.setup()

  adapter.dedicate()
end

return M
