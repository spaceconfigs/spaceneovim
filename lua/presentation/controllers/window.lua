local make_controller_logged = require("application.helpers.make_controller_logged")
local window_usecase = require("application.ports.usecase_registry").window()

---@type WindowContract
local M = {
  toggle = function()
    return function()
      window_usecase.toggle()
    end
  end,

  go = function(opts)
    return function()
      window_usecase.go(opts.direction)
    end
  end,

  move = function(opts)
    return function()
      window_usecase.move(opts.direction)
    end
  end,

  move_far = function(opts)
    return function()
      window_usecase.move_far(opts.direction)
    end
  end,

  resize = function(opts)
    return function()
      window_usecase.resize(opts)
    end
  end,

  resize_transient = function(opts)
    return function()
      window_usecase.resize_transient(opts)
    end
  end,

  balance_area = function()
    return function()
      window_usecase.balance_area()
    end
  end,

  go_to = function(opts)
    return function()
      window_usecase.go_to(opts.number)
    end
  end,

  close = function()
    return function()
      window_usecase.close()
    end
  end,

  split = function(opts)
    return function()
      window_usecase.split(opts)
    end
  end,

  dedicate = function()
    return function()
      window_usecase.dedicate()
    end
  end,
}

return make_controller_logged("window", M)
