---@type WindowUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
  setup = function()
    return require("application.ports.adapter_registry").window()
  end,

  toggle = function()
    local adapter = M.setup()

    adapter.toggle()
  end,

  go = function(opts)
    local adapter = M.setup()

    adapter.go(opts.direction)
  end,

  move = function(opts)
    local adapter = M.setup()

    adapter.move(opts.direction)
  end,

  move_far = function(direction)
    local adapter = M.setup()

    adapter.move_far(direction)
  end,

  resize = function(opts)
    local adapter = M.setup()

    adapter.resize(opts)
  end,

  balance_area = function()
    local adapter = M.setup()

    adapter.balance()
  end,

  scroll = function(opts)
    local adapter = M.setup()

    adapter.scroll(opts.direction)
  end,

  go_to = function(number)
    local adapter = M.setup()

    adapter.go_to(number)
  end,

  close = function()
    local adapter = M.setup()

    adapter.close()
  end,

  split = function(opts)
    local adapter = M.setup()

    adapter.split(opts)
  end,

  layout = function(opts)
    local adapter = M.setup()

    adapter.layout(opts)
  end,

  dedicate = function()
    local adapter = M.setup()

    adapter.dedicate()
  end,
}

return make_logged("usecases/window", M)
