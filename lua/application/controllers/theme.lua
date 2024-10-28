local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local theme_use_case = require("application.use_cases.theme")

M.list = function()
	return function()
		theme_use_case.list()
	end
end

M.load = function()
	return function()
		theme_use_case.load()
	end
end

return make_controller_logged("theme", M)
