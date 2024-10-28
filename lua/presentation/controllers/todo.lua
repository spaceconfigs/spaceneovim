local make_controller_logged = require("application.helpers.make_controller_logged")
local todo_usecase = require("application.ports.usecase_registry").todo()

---@type TodoContract
local M = {
  list = function()
    return function()
      todo_usecase.list()
    end
  end,
}

return make_controller_logged("todo", M)
