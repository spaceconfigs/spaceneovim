local M = {}

local logger_use_case = require("application.use_cases.logger")
local debugger_use_case = require("application.use_cases.debugger")

M.clear_breakpoints = function()
	return function()
		local message = {
			module = "controllers/debugger",
			func = "clear_breakpoints",
		}
		logger_use_case.debug(message)
		debugger_use_case.clear_breakpoints()
	end
end

M.close = function()
	return function()
		local message = {
			module = "controllers/debugger",
			func = "close",
		}
		logger_use_case.debug(message)
		debugger_use_case.close()
	end
end

M.continue = function()
	return function()
		local message = {
			module = "controllers/debugger",
			func = "continue",
		}
		logger_use_case.debug(message)
		debugger_use_case.continue()
	end
end

M.focus_frame = function()
	return function()
		local message = {
			module = "controllers/debugger",
			func = "focus_frame",
		}
		logger_use_case.debug(message)
		debugger_use_case.focus_frame()
	end
end

M.go_up = function()
	return function()
		local message = {
			module = "controllers/debugger",
			func = "go_up",
		}
		logger_use_case.debug(message)
		debugger_use_case.go_up()
	end
end

M.go_down = function()
	return function()
		local message = {
			module = "controllers/debugger",
			func = "go_down",
		}
		logger_use_case.debug(message)
		debugger_use_case.go_down()
	end
end

M.hover = function()
	return function()
		local message = {
			module = "controllers/debugger",
			func = "hover",
		}
		logger_use_case.debug(message)
		debugger_use_case.hover()
	end
end

M.list_breakpoints = function()
	return function()
		local message = {
			module = "controllers/debugger",
			func = "list_breakpoints",
		}
		logger_use_case.debug(message)
		debugger_use_case.list_breakpoints()
	end
end

M.list_frames = function()
	return function()
		local message = {
			module = "controllers/debugger",
			func = "list_frames",
		}
		logger_use_case.debug(message)
		debugger_use_case.list_frames()
	end
end

M.open = function()
	return function()
		local message = {
			module = "controllers/debugger",
			func = "open",
		}
		logger_use_case.debug(message)
		debugger_use_case.open()
	end
end

M.preview = function()
	return function()
		local message = {
			module = "controllers/debugger",
			func = "preview",
		}
		logger_use_case.debug(message)
		debugger_use_case.preview()
	end
end

M.set_exception_breakpoints = function()
	return function()
		local message = {
			module = "controllers/debugger",
			func = "set_exception_breakpoints",
		}
		logger_use_case.debug(message)
		debugger_use_case.set_exception_breakpoints()
	end
end

M.step_over = function()
	return function()
		local message = {
			module = "controllers/debugger",
			func = "step_over",
		}
		logger_use_case.debug(message)
		debugger_use_case.step_over()
	end
end

M.step_into = function()
	return function()
		local message = {
			module = "controllers/debugger",
			func = "step_into",
		}
		logger_use_case.debug(message)
		debugger_use_case.step_into()
	end
end

M.step_out = function()
	return function()
		local message = {
			module = "controllers/debugger",
			func = "step_out",
		}
		logger_use_case.debug(message)
		debugger_use_case.step_out()
	end
end

M.step_back = function()
	return function()
		local message = {
			module = "controllers/debugger",
			func = "step_back",
		}
		logger_use_case.debug(message)
		debugger_use_case.step_back()
	end
end

M.set_breakpoint = function()
	return function()
		local message = {
			module = "controllers/debugger",
			func = "set_breakpoint",
		}
		logger_use_case.debug(message)
		debugger_use_case.set_breakpoint()
	end
end

M.toggle_breakpoint = function()
	return function()
		local message = {
			module = "controllers/debugger",
			func = "toggle_breakpoint",
		}
		logger_use_case.debug(message)
		debugger_use_case.toggle_breakpoint()
	end
end

M.repl_toggle = function()
	return function()
		local message = {
			module = "controllers/debugger",
			func = "repl_toggle",
		}
		logger_use_case.debug(message)
		debugger_use_case.repl_toggle()
	end
end

M.run_last = function()
	return function()
		local message = {
			module = "controllers/debugger",
			func = "run_last",
		}
		logger_use_case.debug(message)
		debugger_use_case.run_last()
	end
end

M.run_to_cursor = function()
	return function()
		local message = {
			module = "controllers/debugger",
			func = "run_to_cursor",
		}
		logger_use_case.debug(message)
		debugger_use_case.run_to_cursor()
	end
end

M.restart_frame = function()
	return function()
		local message = {
			module = "controllers/debugger",
			func = "restart_frame",
		}
		logger_use_case.debug(message)
		debugger_use_case.restart_frame()
	end
end

M.list_variables = function()
	return function()
		local message = {
			module = "controllers/debugger",
			func = "list_variables",
		}
		logger_use_case.debug(message)
		debugger_use_case.list_variables()
	end
end

return M
