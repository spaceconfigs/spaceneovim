local make_controller_logged = require("application.helpers.make_controller_logged")
local noter_usecase = require("application.ports.usecase_registry").noter()

---@type NoterContract
local M = {
	new = function()
		return function()
			noter_usecase.new()
		end
	end,

	list = function()
		return function()
			noter_usecase.list()
		end
	end,

	dismiss = function()
		return function()
			noter_usecase.dismiss()
		end
	end,

	find = function()
		return function()
			noter_usecase.find()
		end
	end,

	toggle_checkbox = function()
		return function()
			noter_usecase.toggle_checkbox()
		end
	end,

	todo_next_state = function()
		return function()
			noter_usecase.todo_next_state()
		end
	end,

	insert_heading = function()
		return function()
			noter_usecase.insert_heading()
		end
	end,
}

return make_controller_logged("noter", M)
