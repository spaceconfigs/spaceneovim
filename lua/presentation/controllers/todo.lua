local make_controller_logged = require("application.helpers.make_controller_logged")
local todo_use_case = require("application.ports.use_case_registry").todo()

---@type TodoContract
local M = {
  list = function()
    return function()
      todo_use_case.list()
    end
  end,
}

return make_controller_logged("todo", M)
