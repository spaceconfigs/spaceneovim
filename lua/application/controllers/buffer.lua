local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local buffer_use_case = require("application.use_cases.buffer")

M.add = function()
	return function()
		buffer_use_case.add()
	end
end

M.delete = function()
	return function()
		buffer_use_case.delete()
	end
end

M.close_others = function()
	return function()
		buffer_use_case.close_others()
	end
end

M.list = function()
	return function()
		buffer_use_case.list()
	end
end

M.next = function()
	return function()
		buffer_use_case.next()
	end
end

M.previous = function()
	return function()
		buffer_use_case.previous()
	end
end

M.messages = function()
	return function()
		buffer_use_case.messages()
	end
end

M.reopen = function()
	return function()
		buffer_use_case.reopen()
	end
end

return make_controller_logged("buffer", M)
