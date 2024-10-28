local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local bookmarker_use_case = require("application.use_cases.bookmarker")

M.add = function()
	return function()
		bookmarker_use_case.add()
	end
end

M.remove = function()
	return function()
		bookmarker_use_case.remove()
	end
end

M.remove_all = function()
	return function()
		bookmarker_use_case.remove_all()
	end
end

M.list = function()
	return function()
		bookmarker_use_case.list()
	end
end

return make_controller_logged("bookmarker", M)
