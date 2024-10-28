local make_controller_logged = require("application.helpers.make_controller_logged")
local versior_use_case = require("application.use_cases.versior")

---@type VersiorContract
local M = {
	blame = function(opts)
		return function()
			versior_use_case.blame(opts)
		end
	end,

	open = function()
		return function()
			versior_use_case.open()
		end
	end,

	stage_file = function()
		return function()
			versior_use_case.stage_file()
		end
	end,

	unstage_file = function()
		return function()
			versior_use_case.unstage_file()
		end
	end,

	browse = function()
		return function()
			versior_use_case.browse()
		end
	end,

	branches = function()
		return function()
			versior_use_case.branches()
		end
	end,

	log = function()
		return function()
			versior_use_case.log()
		end
	end,

	jump_file = function(opts)
		return function()
			versior_use_case.jump_file(opts)
		end
	end,
}

return make_controller_logged("versior", M)
