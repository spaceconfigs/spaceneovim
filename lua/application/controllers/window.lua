local make_controller_logged = require("application.helpers.make_controller_logged")
local window_use_case = require("application.use_cases.window")

---@type WindowContract
local M = {
  toggle = function()
    return function()
      window_use_case.toggle()
    end
  end,

  go = function(opts)
    return function()
      window_use_case.go(opts.direction)
    end
  end,

  move = function(opts)
    return function()
      window_use_case.move(opts.direction)
    end
  end,

  move_far = function(opts)
    return function()
      window_use_case.move_far(opts.direction)
    end
  end,

  resize = function(opts)
    return function()
      window_use_case.resize(opts)
    end
  end,

  resize_transient = function(opts)
    return function()
      window_use_case.resize_transient(opts)
    end
  end,

  balance_area = function()
    return function()
      window_use_case.balance_area()
    end
  end,

  go_to = function(opts)
    return function()
      window_use_case.go_to(opts.number)
    end
  end,

  close = function()
    return function()
      window_use_case.close()
    end
  end,

  split = function(opts)
    return function()
      window_use_case.split(opts)
    end
  end,

  dedicate = function()
    return function()
      window_use_case.dedicate()
    end
  end,
}

return make_controller_logged("window", M)
