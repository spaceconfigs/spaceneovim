local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local window_use_case = require("application.use_cases.window")

M.toggle = function()
  return function()
    window_use_case.toggle()
  end
end

M.go = function(opts)
  return function()
    window_use_case.go(opts.direction)
  end
end

M.move = function(opts)
  return function()
    window_use_case.move(opts.direction)
  end
end

M.move_far = function(opts)
  return function()
    window_use_case.move_far(opts.direction)
  end
end

M.resize = function(opts)
  return function()
    window_use_case.resize(opts)
  end
end

M.resize_transient = function(opts)
  return function()
    window_use_case.resize_transient(opts)
  end
end

M.balance_area = function()
  return function()
    window_use_case.balance_area()
  end
end

M.go_to = function(opts)
  return function()
    window_use_case.go_to(opts.number)
  end
end

M.close = function()
  return function()
    window_use_case.close()
  end
end

M.split = function(opts)
  return function()
    window_use_case.split(opts)
  end
end

M.dedicate = function()
  return function()
    window_use_case.dedicate()
  end
end

return make_controller_logged("window", M)
