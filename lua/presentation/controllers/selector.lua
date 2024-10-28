local make_controller_logged = require("application.helpers.make_controller_logged")
local selector_usecase = require("application.ports.use_case_registry").selector()

---@type SelectorContract
local M = {
	quit = function()
		return function()
			selector_usecase.quit()
		end
	end,

	all_selected = function()
		return function()
			selector_usecase.all_selected()
		end
	end,
}

return make_controller_logged("selector", M)
