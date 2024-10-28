local make_controller_logged = require("application.helpers.make_controller_logged")
local debugger_use_case = require("application.use_cases.debugger")

---@type DebuggerContract
local M = {
	clear_breakpoints = function()
		return function()
			debugger_use_case.clear_breakpoints()
		end
	end,

	close = function()
		return function()
			debugger_use_case.close()
		end
	end,

	continue = function()
		return function()
			debugger_use_case.continue()
		end
	end,

	focus_frame = function()
		return function()
			debugger_use_case.focus_frame()
		end
	end,

	go = function(opts)
		return function()
			debugger_use_case.go(opts.direction)
		end
	end,

	hover = function()
		return function()
			debugger_use_case.hover()
		end
	end,

	list_breakpoints = function()
		return function()
			debugger_use_case.list_breakpoints()
		end
	end,

	list_frames = function()
		return function()
			debugger_use_case.list_frames()
		end
	end,

	open = function()
		return function()
			debugger_use_case.open()
		end
	end,

	preview = function()
		return function()
			debugger_use_case.preview()
		end
	end,

	set_exception_breakpoints = function()
		return function()
			debugger_use_case.set_exception_breakpoints()
		end
	end,

	step = function(opts)
		return function()
			debugger_use_case.step(opts.type)
		end
	end,

	set_breakpoint = function()
		return function()
			debugger_use_case.set_breakpoint()
		end
	end,

	toggle_breakpoint = function()
		return function()
			debugger_use_case.toggle_breakpoint()
		end
	end,

	repl_toggle = function()
		return function()
			debugger_use_case.repl_toggle()
		end
	end,

	run_last = function()
		return function()
			debugger_use_case.run_last()
		end
	end,

	run_to_cursor = function()
		return function()
			debugger_use_case.run_to_cursor()
		end
	end,

	restart_frame = function()
		return function()
			debugger_use_case.restart_frame()
		end
	end,

	list_variables = function()
		return function()
			debugger_use_case.list_variables()
		end
	end,
}

return make_controller_logged("debugger", M)
