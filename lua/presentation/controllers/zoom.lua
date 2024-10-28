local make_controller_logged = require("application.helpers.make_controller_logged")
local zoom_usecase = require("application.ports.usecase_registry").zoom()

---@type ZoomContract
local M = {
  change = function(opts)
    return function()
      zoom_usecase.change(opts)
    end
  end,
}

return make_controller_logged("zoom", M)
