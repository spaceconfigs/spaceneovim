local make_controller_logged = require("application.helpers.make_controller_logged")
local tester_usecase = require("application.ports.use_case_registry").tester()

---@type TesterContract
local M = {
	toggle = function(opts)
		return function()
			tester_usecase.toggle(opts)
		end
	end,

	run = function(opts)
		return function()
			tester_usecase.run(opts)
		end
	end,
}

return make_controller_logged("tester", M)
