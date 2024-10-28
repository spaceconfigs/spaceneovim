local make_controller_logged = require("application.helpers.make_controller_logged")
local tree_use_case = require("application.ports.use_case_registry").tree()

---@type TreeContract
local M = {
  open = function()
    return function()
      tree_use_case.open()
    end
  end,

  close = function()
    return function()
      tree_use_case.close()
    end
  end,

  toggle = function(opts)
    return function()
      tree_use_case.toggle(opts)
    end
  end,
}

return make_controller_logged("tree", M)
