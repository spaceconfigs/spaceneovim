local vim = vim
local M = {}

M.setup = function()
	return require("infrastructure.adapters.debugger")
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

M.go_up = function()
	local adapter = M.setup()

	adapter.go_up()
end

M.go_down = function()
	local adapter = M.setup()

	adapter.go_down()
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

	local widgets = require("dap.ui.widgets")

	widgets.centered_float(widgets.frames)
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

M.step_over = function()
	local adapter = M.setup()

	adapter.step_over()
end

M.step_into = function()
	local adapter = M.setup()

	adapter.step_into()
end

M.step_out = function()
	local adapter = M.setup()

	adapter.step_out()
end

M.step_back = function()
	local adapter = M.setup()

	adapter.step_back()
end

M.set_breakpoint = function()
	local adapter = M.setup()

	local condition = vim.fn.input("Condition: ")

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

	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end

return M
