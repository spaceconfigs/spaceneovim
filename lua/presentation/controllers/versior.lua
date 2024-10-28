local make_controller_logged = require("application.helpers.make_controller_logged")
local versior_usecase = require("application.ports.usecase_registry").versior()

---@type VersiorContract
local M = {
	blame = function(opts)
		return function()
			versior_usecase.blame(opts)
		end
	end,

	open = function()
		return function()
			versior_usecase.open()
		end
	end,

	stage_file = function()
		return function()
			versior_usecase.stage_file()
		end
	end,

	unstage_file = function()
		return function()
			versior_usecase.unstage_file()
		end
	end,

	browse = function()
		return function()
			versior_usecase.browse()
		end
	end,

	branches = function()
		return function()
			versior_usecase.branches()
		end
	end,

	log = function()
		return function()
			versior_usecase.log()
		end
	end,

	jump_file = function(opts)
		return function()
			versior_usecase.jump_file(opts)
		end
	end,

	time_machine = function()
		return function()
			versior_usecase.time_machine()
		end
	end,
}

return make_controller_logged("versior", M)
