local make_controller_logged = require("application.helpers.make_controller_logged")
local window_usecase = require("application.ports.usecase_registry").window()

---@type WindowContract
local M = {
  toggle = function(opts)
    return function()
      window_usecase.toggle(opts)
    end
  end,

  go = function(opts)
    return function()
      window_usecase.go(opts)
    end
  end,

  move = function(opts)
    return function()
      window_usecase.move(opts)
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

  balance_area = function(opts)
    return function()
      window_usecase.balance_area(opts)
    end
  end,

  go_to = function(opts)
    return function()
      window_usecase.go_to(opts.number)
    end
  end,

  close = function(opts)
    return function()
      window_usecase.close(opts)
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
