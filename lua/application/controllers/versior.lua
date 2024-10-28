local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local versior_use_case = require("application.use_cases.versior")

M.blame = function(opts)
	return function()
		versior_use_case.blame(opts)
	end
end

M.open = function()
	return function()
		versior_use_case.open()
	end
end

M.stage_file = function()
	return function()
		versior_use_case.stage_file()
	end
end

M.unstage_file = function()
	return function()
		versior_use_case.unstage_file()
	end
end

M.browse = function()
	return function()
		versior_use_case.browse()
	end
end

M.branches = function()
	return function()
		versior_use_case.branches()
	end
end

M.log = function()
	return function()
		versior_use_case.log()
	end
end

M.jump_file = function(opts)
	return function()
		versior_use_case.jump_file(opts)
	end
end

return make_controller_logged("versior", M)
