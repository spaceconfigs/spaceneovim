local make_controller_logged = require("application.helpers.make_controller_logged")
local documentation_usecase = require("application.ports.usecase_registry").documentation()

---@type DocumentationContract
local M = {
	open = function()
		return function()
			documentation_usecase.open()
		end
	end,

	install = function()
		return function()
			documentation_usecase.install()
		end
	end,

	remove = function()
		return function()
			documentation_usecase.remove()
		end
	end,
}

return make_controller_logged("documentation", M)
