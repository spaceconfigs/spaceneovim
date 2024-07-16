local vim = vim
local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infraestrucuture.adapters.debugger")
end

M.clear_breakpoints = function()
	local message = {
		module = "use_cases/debugger",
		func = "clear_breakpoints",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.clear_breakpoints()
end

M.close = function()
	local message = {
		module = "use_cases/debugger",
		func = "close",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.close()
end

M.continue = function()
	local message = {
		module = "use_cases/debugger",
		func = "continue",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.continue()
end

M.focus_frame = function()
	local message = {
		module = "use_cases/debugger",
		func = "focus_frame",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.focus_frame()
end

M.go_up = function()
	local message = {
		module = "use_cases/debugger",
		func = "go_up",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.go_up()
end

M.go_down = function()
	local message = {
		module = "use_cases/debugger",
		func = "go_down",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.go_down()
end

M.hover = function()
	local message = {
		module = "use_cases/debugger",
		func = "hover",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.hover()
end

M.list_breakpoints = function()
	local message = {
		module = "use_cases/debugger",
		func = "list_breakpoints",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.list_breakpoints()
end

M.list_frames = function()
	local message = {
		module = "use_cases/debugger",
		func = "list_frames",
	}
	logger_use_case.debug(message)
  local adapter = M.setup()

	local widgets = require("dap.ui.widgets")

	widgets.centered_float(widgets.frames)
end

M.open = function()
	local message = {
		module = "use_cases/debugger",
		func = "open",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.open()
end

M.preview = function()
	local message = {
		module = "use_cases/debugger",
		func = "preview",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.hover()
end

M.set_exception_breakpoints = function()
	local message = {
		module = "use_cases/debugger",
		func = "set_exception_breakpoints",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.set_exception_breakpoints()
end

M.step_over = function()
	local message = {
		module = "use_cases/debugger",
		func = "step_over",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.step_over()
end

M.step_into = function()
	local message = {
		module = "use_cases/debugger",
		func = "step_into",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.step_into()
end

M.step_out = function()
	local message = {
		module = "use_cases/debugger",
		func = "step_out",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.step_out()
end

M.step_back = function()
	local message = {
		module = "use_cases/debugger",
		func = "step_back",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.step_back()
end

M.set_breakpoint = function()
	local message = {
		module = "use_cases/debugger",
		func = "set_breakpoint",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	local condition = vim.fn.input("Condition: ")

	adapter.set_breakpoint({ condition = condition })
end

M.toggle_breakpoint = function()
	local message = {
		module = "use_cases/debugger",
		func = "toggle_breakpoint",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.toggle_breakpoint()
end

M.repl_toggle = function()
	local message = {
		module = "use_cases/debugger",
		func = "repl_toggle",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.repl_toggle()
end

M.run_last = function()
	local message = {
		module = "use_cases/debugger",
		func = "run_last",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.run_last()
end

M.run_to_cursor = function()
	local message = {
		module = "use_cases/debugger",
		func = "run_to_cursor",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.run_to_cursor()
end

M.restart_frame = function()
	local message = {
		module = "use_cases/debugger",
		func = "restart_frame",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.restart_frame()
end

M.list_variables = function()
	local message = {
		module = "use_cases/debugger",
		func = "list_variables",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end

return M
