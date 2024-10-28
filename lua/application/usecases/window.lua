local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
  return require("application.ports.adapter_registry").window()
end

M.toggle = function()
  local adapter = M.setup()

  adapter.toggle()
end

---@param opts { direction: "up"|"down"|"left"|"right" }
M.go = function(opts)
  local adapter = M.setup()

  adapter.go(opts.direction)
end

---@param opts { direction: "up"|"down"|"left"|"right" }
M.move = function(opts)
  local adapter = M.setup()

  adapter.move(opts.direction)
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
