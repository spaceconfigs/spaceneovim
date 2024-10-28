local make_controller_logged = require("application.helpers.make_controller_logged")
local theme_usecase = require("application.ports.use_case_registry").theme()

---@type ThemeContract
local M = {
	list = function()
		return function()
			theme_usecase.list()
		end
	end,

	load = function()
		return function()
			theme_usecase.load()
		end
	end,
}

return make_controller_logged("theme", M)
