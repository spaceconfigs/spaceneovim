local make_controller_logged = require("application.helpers.make_controller_logged")
local quit_use_case = require("application.use_cases.quit")

---@type QuitContract
local M = {
  quit = function(opts)
    return function()
      quit_use_case.quit(opts)
    end
  end,

  restart = function()
    return function()
      quit_use_case.restart()
    end
  end,
}

return make_controller_logged("quit", M)
