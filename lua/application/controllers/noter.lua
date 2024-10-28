local make_controller_logged = require("application.helpers.make_controller_logged")
local noter_use_case = require("application.use_cases.noter")

---@type NoterContract
local M = {
	new = function()
		return function()
			noter_use_case.new()
		end
	end,

	list = function()
		return function()
			noter_use_case.list()
		end
	end,

	dismiss = function()
		return function()
			noter_use_case.dismiss()
		end
	end,

	find = function()
		return function()
			noter_use_case.find()
		end
	end,

	toggle_checkbox = function()
		return function()
			noter_use_case.toggle_checkbox()
		end
	end,

	todo_next_state = function()
		return function()
			noter_use_case.todo_next_state()
		end
	end,

	insert_heading = function()
		return function()
			noter_use_case.insert_heading()
		end
	end,
}

return make_controller_logged("noter", M)
