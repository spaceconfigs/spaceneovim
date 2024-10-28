local make_controller_logged = require("application.helpers.make_controller_logged")
local keymapper_usecase = require("application.usecases.keymapper")

---@type KeymapperContract
local M = {
  activate_transient = function(opts)
    return function()
      keymapper_usecase.show({ keys = opts.keys, loop = true })
    end
  end,
  open = function(opts)
    return function()
      keymapper_usecase.show({ keys = opts.keys })
    end
  end,
}

return make_controller_logged("keymapper", M)
