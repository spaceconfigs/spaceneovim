local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local selector_use_case = require("application.use_cases.selector")

M.quit = function()
	return function()
		selector_use_case.quit()
	end
end

M.all_selected = function()
	return function()
		selector_use_case.all_selected()
	end
end

return make_controller_logged("selector", M)
