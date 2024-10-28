local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local noter_use_case = require("application.use_cases.noter")

M.new = function()
	return function()
		noter_use_case.new()
	end
end

M.list = function()
	return function()
		noter_use_case.list()
	end
end

M.dismiss = function()
	return function()
		noter_use_case.dismiss()
	end
end

M.find = function()
	return function()
		noter_use_case.find()
	end
end

M.toggle_checkbox = function()
	return function()
		noter_use_case.toggle_checkbox()
	end
end

M.todo_next_state = function()
	return function()
		noter_use_case.todo_next_state()
	end
end

M.insert_heading = function()
	return function()
		noter_use_case.insert_heading()
	end
end

return make_controller_logged("noter", M)
