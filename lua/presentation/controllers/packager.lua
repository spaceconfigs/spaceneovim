local make_controller_logged = require("application.helpers.make_controller_logged")
local packager_usecase = require("application.ports.usecase_registry").packager()

---@type PackagerContract
local M = {
	install = function()
		return function()
			packager_usecase.install()
		end
	end,

	update = function()
		return function()
			packager_usecase.update()
		end
	end,
}

return make_controller_logged("packager", M)
