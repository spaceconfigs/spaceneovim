local make_controller_logged = require("application.helpers.make_controller_logged")
local jumper_use_case = require("application.ports.use_case_registry").jumper()

---@type JumperContract
local M = {
  timer = function(options)
    return function()
      jumper_use_case.timer(options)
    end
  end,

  words = function()
    return function()
      jumper_use_case.words()
    end
  end,

  lines = function()
    return function()
      jumper_use_case.lines()
    end
  end,

  remote = function()
    return function()
      jumper_use_case.remote()
    end
  end,
}

return make_controller_logged("jumper", M)
