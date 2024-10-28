local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("application.ports.registry").debugger()
end

M.clear_breakpoints = function()
	local adapter = M.setup()

	adapter.clear_breakpoints()
end

M.close = function()
	local adapter = M.setup()

	adapter.close()
end

M.continue = function()
	local adapter = M.setup()

	adapter.continue()
end

M.focus_frame = function()
	local adapter = M.setup()

	adapter.focus_frame()
end

---@param direction "up"|"down"
M.go = function(direction)
	local adapter = M.setup()

	adapter.go(direction)
end

M.hover = function()
	local adapter = M.setup()

	adapter.hover()
end

M.list_breakpoints = function()
	local adapter = M.setup()

	adapter.list_breakpoints()
end

M.list_frames = function()
	local adapter = M.setup()

	adapter.list_frames()
end

M.open = function()
	local adapter = M.setup()

	adapter.open()
end

M.preview = function()
	local adapter = M.setup()

	adapter.hover()
end

M.set_exception_breakpoints = function()
	local adapter = M.setup()

	adapter.set_exception_breakpoints()
end

---@param type "into"|"out"|"over"|"back"
M.step = function(type)
	local adapter = M.setup()

	adapter.step(type)
end

M.set_breakpoint = function()
	local adapter = M.setup()
	local editor = require("application.ports.registry").editor()

	local condition = editor.prompt("Condition: ")

	adapter.set_breakpoint({ condition = condition })
end

M.toggle_breakpoint = function()
	local adapter = M.setup()

	adapter.toggle_breakpoint()
end

M.repl_toggle = function()
	local adapter = M.setup()

	adapter.repl_toggle()
end

M.run_last = function()
	local adapter = M.setup()

	adapter.run_last()
end

M.run_to_cursor = function()
	local adapter = M.setup()

	adapter.run_to_cursor()
end

M.restart_frame = function()
	local adapter = M.setup()

	adapter.restart_frame()
end

M.list_variables = function()
	local adapter = M.setup()

	adapter.list_variables()
end

return make_logged("usecases/debugger", M)
