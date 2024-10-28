local M = {}
local make_logged = require("application.helpers.make_logged")

local keymapper_usecase = require("application.usecases.keymapper")

local resize_transient = nil

M.setup = function()
  return require("application.ports.adapter_registry").window()
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
  local adapter = M.setup()

  adapter.resize(opts)
end

M.balance_area = function()
  local adapter = M.setup()

  adapter.balance()
end

---@param opts { axis: "width"|"height", delta: integer }
M.resize_transient = function(opts)
  M.resize(opts)

  if resize_transient == nil then
    resize_transient = keymapper_usecase.create_transient({
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

return make_logged("usecases/window", M)
