local make_controller_logged = require("application.helpers.make_controller_logged")
local debugger_usecase = require("application.ports.use_case_registry").debugger()

---@type DebuggerContract
local M = {
	clear_breakpoints = function()
		return function()
			debugger_usecase.clear_breakpoints()
		end
	end,

	close = function()
		return function()
			debugger_usecase.close()
		end
	end,

	continue = function()
		return function()
			debugger_usecase.continue()
		end
	end,

	focus_frame = function()
		return function()
			debugger_usecase.focus_frame()
		end
	end,

	go = function(opts)
		return function()
			debugger_usecase.go(opts.direction)
		end
	end,

	hover = function()
		return function()
			debugger_usecase.hover()
		end
	end,

	list_breakpoints = function()
		return function()
			debugger_usecase.list_breakpoints()
		end
	end,

	list_frames = function()
		return function()
			debugger_usecase.list_frames()
		end
	end,

	open = function()
		return function()
			debugger_usecase.open()
		end
	end,

	preview = function()
		return function()
			debugger_usecase.preview()
		end
	end,

	set_exception_breakpoints = function()
		return function()
			debugger_usecase.set_exception_breakpoints()
		end
	end,

	step = function(opts)
		return function()
			debugger_usecase.step(opts.type)
		end
	end,

	set_breakpoint = function()
		return function()
			debugger_usecase.set_breakpoint()
		end
	end,

	toggle_breakpoint = function()
		return function()
			debugger_usecase.toggle_breakpoint()
		end
	end,

	repl_toggle = function()
		return function()
			debugger_usecase.repl_toggle()
		end
	end,

	run_last = function()
		return function()
			debugger_usecase.run_last()
		end
	end,

	run_to_cursor = function()
		return function()
			debugger_usecase.run_to_cursor()
		end
	end,

	restart_frame = function()
		return function()
			debugger_usecase.restart_frame()
		end
	end,

	list_variables = function()
		return function()
			debugger_usecase.list_variables()
		end
	end,
}

return make_controller_logged("debugger", M)
