local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local notebook_use_case = require("application.use_cases.notebook")

M.activate_transient = function()
	return function()
		notebook_use_case.activate_transient()
	end
end

M.send_motion = function(opts)
	return function()
		notebook_use_case.send_motion(opts)
	end
end

M.send_line = function(opts)
	return function()
		notebook_use_case.send_line(opts)
	end
end

M.send_file = function(opts)
	return function()
		notebook_use_case.send_file(opts)
	end
end

M.send_until_cursor = function(opts)
	return function()
		notebook_use_case.send_until_cursor(opts)
	end
end

M.send_mark = function(opts)
	return function()
		notebook_use_case.send_mark(opts)
	end
end

M.repl_here = function(opts)
	return function()
		notebook_use_case.repl_here(opts)
	end
end

M.repl_restart = function(opts)
	return function()
		notebook_use_case.repl_restart(opts)
	end
end

M.interrupt = function(opts)
	return function()
		notebook_use_case.interrupt(opts)
	end
end

M.exit = function(opts)
	return function()
		notebook_use_case.exit(opts)
	end
end

M.clear = function(opts)
	return function()
		notebook_use_case.clear(opts)
	end
end

M.focus = function(opts)
	return function()
		notebook_use_case.focus(opts)
	end
end

M.toggle = function(opts)
	return function()
		notebook_use_case.toggle(opts)
	end
end

M.goto_cell = function(opts)
	return function()
		notebook_use_case.goto_cell(opts)
	end
end

M.delete_cell = function(opts)
	return function()
		notebook_use_case.delete_cell(opts)
	end
end

M.insert_cell = function(opts)
	return function()
		notebook_use_case.insert_cell(opts)
	end
end

M.execute_cell = function(opts)
	return function()
		notebook_use_case.execute_cell(opts)
	end
end

M.execute_and_goto_next = function(opts)
	return function()
		notebook_use_case.execute_and_goto_next(opts)
	end
end

M.save = function(opts)
	return function()
		notebook_use_case.save(opts)
	end
end

M.toggle_output_visibility = function(opts)
	return function()
		notebook_use_case.toggle_output_visibility(opts)
	end
end

M.reevaluate_cell = function(opts)
	return function()
		notebook_use_case.reevaluate_cell(opts)
	end
end

return make_controller_logged("notebook", M)
