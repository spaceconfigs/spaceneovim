local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local layout_use_case = require("application.use_cases.layout")

M.list = function()
	return function()
		layout_use_case.list()
	end
end

M.reload = function()
	return function()
		layout_use_case.reload()
	end
end

M.save = function()
	return function()
		layout_use_case.save()
	end
end

M.delete = function()
	return function()
		layout_use_case.delete()
	end
end

M.rename = function()
	return function()
		layout_use_case.rename()
	end
end

M.previous = function()
	return function()
		layout_use_case.previous()
	end
end

return make_controller_logged("layout", M)
