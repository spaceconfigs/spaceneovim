local vim = vim
local M = {}
local make_logged = require("application.helpers.make_logged")

local keymapper_use_case = require("application.use_cases.keymapper")

local resize_transient = nil

M.setup = function()
  return require("infrastructure.adapters.window")
end

M.toggle = function()
  local adapter = M.setup()

  adapter.toggle()
end

---@param direction "up"|"down"|"left"|"right"
M.go = function(direction)
  local adapter = M.setup()

  adapter.go(direction)
end

---@param direction "up"|"down"|"left"|"right"
M.move = function(direction)
  local adapter = M.setup()

  adapter.move(direction)
end

---@param direction "up"|"down"|"left"|"right"
M.move_far = function(direction)
  local adapter = M.setup()

  adapter.move_far(direction)
end

---@param opts { axis: "width"|"height", delta: integer }
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

---@param opts { axis: "width"|"height", delta: integer }
M.resize_transient = function(opts)
  M.resize(opts)

  if resize_transient == nil then
    resize_transient = keymapper_use_case.create_transient({
      color = "red",
      hint = [[
 Resize window
 _[_/_]_: width   _{_/_}_: height   _=_: balance

 _<Esc>_: exit
]],
      heads = {
        { "[",     function() M.resize({ axis = "width", delta = 5 }) end,   { desc = "Expand width" } },
        { "]",     function() M.resize({ axis = "width", delta = -5 }) end,  { desc = "Shrink width" } },
        { "{",     function() M.resize({ axis = "height", delta = 5 }) end,  { desc = "Expand height" } },
        { "}",     function() M.resize({ axis = "height", delta = -5 }) end, { desc = "Shrink height" } },
        { "=",     function() M.balance_area() end,                          { desc = "Balance area" } },
        { "<Esc>", nil,                                                      { exit = true } },
      },
    })
  end

  resize_transient:activate()
end

---@param number integer
M.go_to = function(number)
  local adapter = M.setup()

  adapter.go_to(number)
end

M.close = function()
  local adapter = M.setup()

  adapter.close()
end

---@param opts { type: "split"|"vsplit", previous?: boolean }
M.split = function(opts)
  local adapter = M.setup()

  adapter.split(opts)
end

M.dedicate = function()
  local adapter = M.setup()

  adapter.dedicate()
end

return make_logged("use_cases/window", M)
