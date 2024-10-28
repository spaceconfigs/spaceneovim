local make_controller_logged = require("application.helpers.make_controller_logged")
local packager_use_case = require("application.ports.use_case_registry").packager()

---@type PackagerContract
local M = {
	install = function()
		return function()
			packager_use_case.install()
		end
	end,

	update = function()
		return function()
			packager_use_case.update()
		end
	end,
}

return make_controller_logged("packager", M)
