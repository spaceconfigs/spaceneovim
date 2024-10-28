local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local packager_use_case = require("application.use_cases.packager")

M.install = function()
	return function()
		packager_use_case.install()
	end
end

M.update = function()
	return function()
		packager_use_case.update()
	end
end

return make_controller_logged("packager", M)
