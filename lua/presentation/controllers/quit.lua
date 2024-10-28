local make_controller_logged = require("application.helpers.make_controller_logged")
local quit_usecase = require("application.ports.use_case_registry").quit()

---@type QuitContract
local M = {
  quit = function(opts)
    return function()
      quit_usecase.quit(opts)
    end
  end,

  restart = function()
    return function()
      quit_usecase.restart()
    end
  end,
}

return make_controller_logged("quit", M)
