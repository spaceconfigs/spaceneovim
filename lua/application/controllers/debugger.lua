local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local debugger_use_case = require("application.use_cases.debugger")

M.clear_breakpoints = function()
	return function()
		debugger_use_case.clear_breakpoints()
	end
end

M.close = function()
	return function()
		debugger_use_case.close()
	end
end

M.continue = function()
	return function()
		debugger_use_case.continue()
	end
end

M.focus_frame = function()
	return function()
		debugger_use_case.focus_frame()
	end
end

M.go = function(opts)
	return function()
		debugger_use_case.go(opts.direction)
	end
end

M.hover = function()
	return function()
		debugger_use_case.hover()
	end
end

M.list_breakpoints = function()
	return function()
		debugger_use_case.list_breakpoints()
	end
end

M.list_frames = function()
	return function()
		debugger_use_case.list_frames()
	end
end

M.open = function()
	return function()
		debugger_use_case.open()
	end
end

M.preview = function()
	return function()
		debugger_use_case.preview()
	end
end

M.set_exception_breakpoints = function()
	return function()
		debugger_use_case.set_exception_breakpoints()
	end
end

M.step = function(opts)
	return function()
		debugger_use_case.step(opts.type)
	end
end

M.set_breakpoint = function()
	return function()
		debugger_use_case.set_breakpoint()
	end
end

M.toggle_breakpoint = function()
	return function()
		debugger_use_case.toggle_breakpoint()
	end
end

M.repl_toggle = function()
	return function()
		debugger_use_case.repl_toggle()
	end
end

M.run_last = function()
	return function()
		debugger_use_case.run_last()
	end
end

M.run_to_cursor = function()
	return function()
		debugger_use_case.run_to_cursor()
	end
end

M.restart_frame = function()
	return function()
		debugger_use_case.restart_frame()
	end
end

M.list_variables = function()
	return function()
		debugger_use_case.list_variables()
	end
end

return make_controller_logged("debugger", M)
