local make_controller_logged = require("application.helpers.make_controller_logged")
local documentation_use_case = require("application.ports.use_case_registry").documentation()

---@type DocumentationContract
local M = {
	open = function()
		return function()
			documentation_use_case.open()
		end
	end,

	install = function()
		return function()
			documentation_use_case.install()
		end
	end,
}

return make_controller_logged("documentation", M)
