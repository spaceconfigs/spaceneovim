local M = {}

local logger_use_case = require("application.use_cases.logger")
local notebook_use_case = require("application.use_cases.notebook")

M.activate_transient = function()
	return function()
		local message = {
			module = "controllers/notebook",
			func = "activate_transient",
		}
		logger_use_case.debug(message)
		notebook_use_case.activate_transient()
	end
end

M.send_motion = function(opts)
	return function()
		local message = {
			module = "controllers/notebook",
			func = "send_motion",
			opts = opts,
		}
		logger_use_case.debug(message)
		notebook_use_case.send_motion(opts)
	end
end

M.send_line = function(opts)
	return function()
		local message = {
			module = "controllers/notebook",
			func = "send_line",
			opts = opts,
		}
		logger_use_case.debug(message)
		notebook_use_case.send_line(opts)
	end
end

M.send_file = function(opts)
	return function()
		local message = {
			module = "controllers/notebook",
			func = "send_file",
			opts = opts,
		}
		logger_use_case.debug(message)
		notebook_use_case.send_file(opts)
	end
end

M.send_until_cursor = function(opts)
	return function()
		local message = {
			module = "controllers/notebook",
			func = "send_until_cursor",
			opts = opts,
		}
		logger_use_case.debug(message)
		notebook_use_case.send_until_cursor(opts)
	end
end

M.send_mark = function(opts)
	return function()
		local message = {
			module = "controllers/notebook",
			func = "send_mark",
			opts = opts,
		}
		logger_use_case.debug(message)
		notebook_use_case.send_mark(opts)
	end
end

M.repl_here = function(opts)
	return function()
		local message = {
			module = "controllers/notebook",
			func = "repl_here",
			opts = opts,
		}
		logger_use_case.debug(message)
		notebook_use_case.repl_here(opts)
	end
end

M.repl_restart = function(opts)
	return function()
		local message = {
			module = "controllers/notebook",
			func = "repl_restart",
			opts = opts,
		}
		logger_use_case.debug(message)
		notebook_use_case.repl_restart(opts)
	end
end

M.interrupt = function(opts)
	return function()
		local message = {
			module = "controllers/notebook",
			func = "interrupt",
			opts = opts,
		}
		logger_use_case.debug(message)
		notebook_use_case.interrupt(opts)
	end
end

M.exit = function(opts)
	return function()
		local message = {
			module = "controllers/notebook",
			func = "exit",
			opts = opts,
		}
		logger_use_case.debug(message)
		notebook_use_case.exit(opts)
	end
end

M.clear = function(opts)
	return function()
		local message = {
			module = "controllers/notebook",
			func = "clear",
			opts = opts,
		}
		logger_use_case.debug(message)
		notebook_use_case.clear(opts)
	end
end

M.focus = function(opts)
	return function()
		local message = {
			module = "controllers/notebook",
			func = "focus",
			opts = opts,
		}
		logger_use_case.debug(message)
		notebook_use_case.focus(opts)
	end
end

M.toggle = function(opts)
	return function()
		local message = {
			module = "controllers/notebook",
			func = "toggle",
			opts = opts,
		}
		logger_use_case.debug(message)
		notebook_use_case.toggle(opts)
	end
end

M.goto_cell = function(opts)
	return function()
		local message = {
			module = "controllers/notebook",
			func = "goto_cell",
			opts = opts,
		}
		logger_use_case.debug(message)
		notebook_use_case.goto_cell(opts)
	end
end

M.delete_cell = function(opts)
	return function()
		local message = {
			module = "controllers/notebook",
			func = "delete_cell",
			opts = opts,
		}
		logger_use_case.debug(message)
		notebook_use_case.delete_cell(opts)
	end
end

M.insert_cell = function(opts)
	return function()
		local message = {
			module = "controllers/notebook",
			func = "insert_cell",
			opts = opts,
		}
		logger_use_case.debug(message)
		notebook_use_case.insert_cell(opts)
	end
end

M.execute_cell = function(opts)
	return function()
		local message = {
			module = "controllers/notebook",
			func = "execute_cell",
			opts = opts,
		}
		logger_use_case.debug(message)
		notebook_use_case.execute_cell(opts)
	end
end

M.execute_and_goto_next = function(opts)
	return function()
		local message = {
			module = "controllers/notebook",
			func = "execute_and_goto_next",
			opts = opts,
		}
		logger_use_case.debug(message)
		notebook_use_case.execute_and_goto_next(opts)
	end
end

M.save = function(opts)
	return function()
		local message = {
			module = "controllers/notebook",
			func = "save",
			opts = opts,
		}
		logger_use_case.debug(message)
		notebook_use_case.save(opts)
	end
end

M.toggle_output_visibility = function(opts)
	return function()
		local message = {
			module = "controllers/notebook",
			func = "toggle_output_visibility",
			opts = opts,
		}
		logger_use_case.debug(message)
		notebook_use_case.toggle_output_visibility(opts)
	end
end

M.reevaluate_cell = function(opts)
	return function()
		local message = {
			module = "controllers/notebook",
			func = "reevaluate_cell",
			opts = opts,
		}
		logger_use_case.debug(message)
		notebook_use_case.reevaluate_cell(opts)
	end
end

return M
