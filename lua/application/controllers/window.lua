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

M.shrink_height = function()
	return function()
		local message = {
			module = "controllers/window",
			func = "shrink_height",
		}
		logger_use_case.debug(message)
		window_use_case.shrink_height()
	end
end

M.expand_height = function()
	return function()
		local message = {
			module = "controllers/window",
			func = "expand_height",
		}
		logger_use_case.debug(message)
		window_use_case.expand_height()
	end
end

M.shrink_width = function()
	return function()
		local message = {
			module = "controllers/window",
			func = "shrink_width",
		}
		logger_use_case.debug(message)
		window_use_case.shrink_width()
	end
end

M.expand_width = function()
	return function()
		local message = {
			module = "controllers/window",
			func = "expand_width",
		}
		logger_use_case.debug(message)
		window_use_case.expand_width()
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

M.move_far_up = function()
	return function()
		local message = {
			module = "controllers/window",
			func = "move_far_up",
		}
		logger_use_case.debug(message)
		window_use_case.move_far_up()
	end
end

M.move_far_down = function()
	return function()
		local message = {
			module = "controllers/window",
			func = "move_far_down",
		}
		logger_use_case.debug(message)
		window_use_case.move_far_down()
	end
end

M.move_far_left = function()
	return function()
		local message = {
			module = "controllers/window",
			func = "move_far_left",
		}
		logger_use_case.debug(message)
		window_use_case.move_far_left()
	end
end

M.move_far_right = function()
	return function()
		local message = {
			module = "controllers/window",
			func = "move_far_right",
		}
		logger_use_case.debug(message)
		window_use_case.move_far_right()
	end
end

M.go_left = function()
	return function()
		local message = {
			module = "controllers/window",
			func = "go_left",
		}
		logger_use_case.debug(message)
		window_use_case.go_left()
	end
end

M.go_right = function()
	return function()
		local message = {
			module = "controllers/window",
			func = "go_right",
		}
		logger_use_case.debug(message)
		window_use_case.go_right()
	end
end

M.go_up = function()
	return function()
		local message = {
			module = "controllers/window",
			func = "go_up",
		}
		logger_use_case.debug(message)
		window_use_case.go_up()
	end
end

M.go_down = function()
	return function()
		local message = {
			module = "controllers/window",
			func = "go_down",
		}
		logger_use_case.debug(message)
		window_use_case.go_down()
	end
end

M.move_left = function()
	return function()
		local message = {
			module = "controllers/window",
			func = "move_left",
		}
		logger_use_case.debug(message)
		window_use_case.move_left()
	end
end

M.move_right = function()
	return function()
		local message = {
			module = "controllers/window",
			func = "move_right",
		}
		logger_use_case.debug(message)
		window_use_case.move_right()
	end
end

M.move_up = function()
	return function()
		local message = {
			module = "controllers/window",
			func = "move_up",
		}
		logger_use_case.debug(message)
		window_use_case.move_up()
	end
end

M.move_down = function()
	return function()
		local message = {
			module = "controllers/window",
			func = "move_down",
		}
		logger_use_case.debug(message)
		window_use_case.move_down()
	end
end

M.go_to = function(number)
	return function()
		local message = {
			module = "controllers/window",
			func = "go_to",
			opts = number,
		}
		logger_use_case.debug(message)
		window_use_case.go_to(number)
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

M.split = function()
	return function()
		local message = {
			module = "controllers/window",
			func = "split",
		}
		logger_use_case.debug(message)
		window_use_case.split()
	end
end

M.vsplit = function()
	return function()
		local message = {
			module = "controllers/window",
			func = "vsplit",
		}
		logger_use_case.debug(message)
		window_use_case.vsplit()
	end
end

M.split_previous = function()
	return function()
		local message = {
			module = "controllers/window",
			func = "split_previous",
		}
		logger_use_case.debug(message)
		window_use_case.split_previous()
	end
end

M.vsplit_previous = function()
	return function()
		local message = {
			module = "controllers/window",
			func = "vsplit_previous",
		}
		logger_use_case.debug(message)
		window_use_case.vsplit_previous()
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
