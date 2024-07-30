local vim = vim
local M = {}

local logger_use_manage = require("application.use_cases.logger")

local setup = function()
	local dap = require("infraestrucuture.plugin.nvim-dap")
	local dapui = require("infraestrucuture.plugin.nvim-dap-ui")
	local file = require("infraestrucuture.plugin.file")

	require("infraestrucuture.plugin.nvim-dap-virtual-text")
	require("infraestrucuture.plugin.neodev")

	file.load_extension("dap")
	local telescope_dap = file.extensions.dap

	vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#993939" })
	vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef" })
	vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379" })

	vim.fn.sign_define("DapBreakpoint", { text = "󰝥", texthl = "DapBreakpoint" })
	vim.fn.sign_define("DapBreakpointCondition", { text = "󰮍", texthl = "DapBreakpoint" })
	vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint" })
	vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint" })
	vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped" })

	dap.listeners.after.event_stopped["dapui_config"] = function()
		vim.api.nvim_command("doautocmd User DapStopped")
	end

	dap.listeners.before.event_terminated["dapui_config"] = function()
		vim.api.nvim_command("doautocmd User DapTerminated")
	end

	dap.listeners.before.event_exited["dapui_config"] = function()
		vim.api.nvim_command("doautocmd User DapExited")
	end

	dap.adapters["pwa-node"] = {
		type = "server",
		host = "localhost",
		port = 8123,
		executable = {
			command = "js-debug-adapter",
		},
	}

	for _, language in ipairs({ "typescript", "javascript" }) do
		dap.configurations[language] = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				cwd = "${workspaceFolder}",
			},
			{
				type = "pwa-node",
				request = "attach",
				name = "Attach",
				processId = function()
					return dap.utils.pick_process({ filter = "--inspect" })
				end,
				cwd = "${workspaceFolder}",
			},
		}
	end
	return {
		dap = dap,
		dapui = dapui,
		file = file,
		telescope_dap = telescope_dap,
	}
end

M.clear_breakpoints = function()
	local message = {
		module = "adapters/debugger",
		func = "clear_breakpoints",
	}
	logger_use_manage.debug(message)
	local plugin = setup().dap

	plugin.clear_breakpoints()
end

M.close = function()
	local message = {
		module = "adapters/debugger",
		func = "close",
	}
	logger_use_manage.debug(message)
	local plugin = setup().dap

	plugin.terminate()
	plugin.close()
end

M.continue = function()
	local message = {
		module = "adapters/debugger",
		func = "continue",
	}
	logger_use_manage.debug(message)
	local plugin = setup().dap

	plugin.continue()
end

M.list_frames = function()
	local message = {
		module = "adapters/debugger",
		func = "list_frames",
	}
	logger_use_manage.debug(message)
	local plugin = setup().dap

	plugin.ui.widgets.centered_float(plugin.ui.widgets.frames)
end

M.focus_frame = function()
	local message = {
		module = "adapters/debugger",
		func = "focus_frame",
	}
	logger_use_manage.debug(message)
	local plugin = setup().dap

	plugin.focus_frame()
end

M.go_up = function()
	local message = {
		module = "adapters/debugger",
		func = "go_up",
	}
	logger_use_manage.debug(message)
	local plugin = setup().dap

	plugin.up()
end

M.go_down = function()
	local message = {
		module = "adapters/debugger",
		func = "go_down",
	}
	logger_use_manage.debug(message)
	local plugin = setup().dap

	plugin.down()
end

M.open = function()
	local message = {
		module = "adapters/debugger",
		func = "open",
	}
	logger_use_manage.debug(message)
	local plugin = setup().dapui

	plugin.open()
end

M.preview = function()
	local message = {
		module = "adapters/debugger",
		func = "preview",
	}
	logger_use_manage.debug(message)
	local plugin = setup().dap

	plugin.ui.widgets.preview()
end

M.set_exception_breakpoints = function()
	local message = {
		module = "adapters/debugger",
		func = "set_exception_breakpoints",
	}
	logger_use_manage.debug(message)
	local plugin = setup().dap

	plugin.set_exception_breakpoints()
end

M.step_over = function()
	local message = {
		module = "adapters/debugger",
		func = "step_over",
	}
	logger_use_manage.debug(message)
	local plugin = setup().dap

	plugin.step_over()
end

M.step_into = function()
	local message = {
		module = "adapters/debugger",
		func = "step_into",
	}
	logger_use_manage.debug(message)
	local plugin = setup().dap

	plugin.step_into()
end

M.step_out = function()
	local message = {
		module = "adapters/debugger",
		func = "step_out",
	}
	logger_use_manage.debug(message)
	local plugin = setup().dap

	plugin.step_out()
end

M.hover = function()
	local message = {
		module = "adapters/debugger",
		func = "hover",
	}
	logger_use_manage.debug(message)
	local plugin = setup().dap

	plugin.ui.widgets.hover()
end

M.list_breakpoints = function()
	local message = {
		module = "adapters/debugger",
		func = "list_breakpoints",
	}
	logger_use_manage.debug(message)
	local plugin = setup().telescope_dap

	plugin.list_breakpoints({ show_line = false })
end

M.toggle_breakpoint = function()
	local message = {
		module = "adapters/debugger",
		func = "toggle_breakpoint",
	}
	logger_use_manage.debug(message)
	local plugin = setup().dap

	plugin.toggle_breakpoint()
end

M.list_variables = function()
	local message = {
		module = "adapters/debugger",
		func = "list_variables",
	}
	logger_use_manage.debug(message)
	local plugin = setup().dap

	plugin.ui.widgets.centered_float(plugin.ui.widgets.scopes)
end

M.set_breakpoint = function(opts)
	local message = {
		module = "adapters/debugger",
		func = "set_breakpoint",
		opts = opts,
	}
	logger_use_manage.debug(message)
	local plugin = setup().dap

	local condition = opts and opts.condition or nil

	plugin.set_breakpoint(condition)
end

M.step_back = function()
	local message = {
		module = "adapters/debugger",
		func = "step_back",
	}
	logger_use_manage.debug(message)
	local plugin = setup().dap

	plugin.step_back()
end

M.repl_toggle = function()
	local message = {
		module = "adapters/debugger",
		func = "repl_toggle",
	}
	logger_use_manage.debug(message)
	local plugin = setup().dap

	plugin.repl.toggle()
end

M.run_last = function()
	local message = {
		module = "adapters/debugger",
		func = "run_last",
	}
	logger_use_manage.debug(message)
	local plugin = setup().dap

	plugin.run_last()
end

M.run_to_cursor = function()
	local message = {
		module = "adapters/debugger",
		func = "run_to_cursor",
	}
	logger_use_manage.debug(message)
	local plugin = setup().dap

	plugin.run_to_cursor()
end

M.restart_frame = function()
	local message = {
		module = "adapters/debugger",
		func = "restart_frame",
	}
	logger_use_manage.debug(message)
	local plugin = setup().dap

	plugin.restart_frame()
end

return M
