---@type DebuggerUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
	setup = function()
		return require("application.ports.adapter_registry").debugger()
	end,

	clear_breakpoints = function()
		local adapter = M.setup()

		adapter.clear_breakpoints()
	end,

	close = function()
		local adapter = M.setup()

		adapter.close()
	end,

	continue = function()
		local adapter = M.setup()

		adapter.continue()
	end,

	focus_frame = function()
		local adapter = M.setup()

		adapter.focus_frame()
	end,

	go = function(direction)
		local adapter = M.setup()

		adapter.go(direction)
	end,

	hover = function()
		local adapter = M.setup()

		adapter.hover()
	end,

	list_breakpoints = function()
		local adapter = M.setup()

		adapter.list_breakpoints()
	end,

	list_frames = function()
		local adapter = M.setup()

		adapter.list_frames()
	end,

	open = function()
		local adapter = M.setup()

		adapter.open()
	end,

	preview = function()
		local adapter = M.setup()

		adapter.hover()
	end,

	set_exception_breakpoints = function()
		local adapter = M.setup()

		adapter.set_exception_breakpoints()
	end,

	step = function(type)
		local adapter = M.setup()

		adapter.step(type)
	end,

	set_breakpoint = function()
		local adapter = M.setup()
		local editor = require("application.ports.adapter_registry").editor()

		local condition = editor.prompt("Condition: ")

		adapter.set_breakpoint({ condition = condition })
	end,

	toggle_breakpoint = function()
		local adapter = M.setup()

		adapter.toggle_breakpoint()
	end,

	repl_toggle = function()
		local adapter = M.setup()

		adapter.repl_toggle()
	end,

	run_last = function()
		local adapter = M.setup()

		adapter.run_last()
	end,

	run_to_cursor = function()
		local adapter = M.setup()

		adapter.run_to_cursor()
	end,

	restart_frame = function()
		local adapter = M.setup()

		adapter.restart_frame()
	end,

	list_variables = function()
		local adapter = M.setup()

		adapter.list_variables()
	end,
}

return make_logged("usecases/debugger", M)
