local M = {}

local logger_use_case = require("application.use_cases.logger")
local window_use_case = require("application.use_cases.window")

M.toggle = function()
	return function()
		local message = {
			module = "controllers/window",
			func = "toggle",
		}
		logger_use_case.debug(message)
		window_use_case.toggle()
	end
end

M.go = function(opts)
	return function()
		local message = {
			module = "controllers/window",
			func = "go",
			opts = opts,
		}
		logger_use_case.debug(message)
		window_use_case.go(opts.direction)
	end
end

M.move = function(opts)
	return function()
		local message = {
			module = "controllers/window",
			func = "move",
			opts = opts,
		}
		logger_use_case.debug(message)
		window_use_case.move(opts.direction)
	end
end

M.move_far = function(opts)
	return function()
		local message = {
			module = "controllers/window",
			func = "move_far",
			opts = opts,
		}
		logger_use_case.debug(message)
		window_use_case.move_far(opts.direction)
	end
end

M.resize = function(opts)
	return function()
		local message = {
			module = "controllers/window",
			func = "resize",
			opts = opts,
		}
		logger_use_case.debug(message)
		window_use_case.resize(opts)
	end
end

M.balance_area = function()
	return function()
		local message = {
			module = "controllers/window",
			func = "balance_area",
		}
		logger_use_case.debug(message)
		window_use_case.balance_area()
	end
end

M.go_to = function(opts)
	return function()
		local message = {
			module = "controllers/window",
			func = "go_to",
			opts = opts,
		}
		logger_use_case.debug(message)
		window_use_case.go_to(opts.number)
	end
end

M.close = function()
	return function()
		local message = {
			module = "controllers/window",
			func = "close",
		}
		logger_use_case.debug(message)
		window_use_case.close()
	end
end

M.split = function(opts)
	return function()
		local message = {
			module = "controllers/window",
			func = "split",
			opts = opts,
		}
		logger_use_case.debug(message)
		window_use_case.split(opts)
	end
end

M.dedicate = function()
	return function()
		local message = {
			module = "controllers/window",
			func = "dedicate",
		}
		logger_use_case.debug(message)
		window_use_case.dedicate()
	end
end

return M
