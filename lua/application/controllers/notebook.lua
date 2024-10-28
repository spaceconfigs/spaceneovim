local make_controller_logged = require("application.helpers.make_controller_logged")
local notebook_use_case = require("application.use_cases.notebook")

---@type NotebookContract
local M = {
	activate_transient = function()
		return function()
			notebook_use_case.activate_transient()
		end
	end,

	send_motion = function(opts)
		return function()
			notebook_use_case.send_motion(opts)
		end
	end,

	send_line = function(opts)
		return function()
			notebook_use_case.send_line(opts)
		end
	end,

	send_file = function(opts)
		return function()
			notebook_use_case.send_file(opts)
		end
	end,

	send_until_cursor = function(opts)
		return function()
			notebook_use_case.send_until_cursor(opts)
		end
	end,

	send_mark = function(opts)
		return function()
			notebook_use_case.send_mark(opts)
		end
	end,

	repl_here = function(opts)
		return function()
			notebook_use_case.repl_here(opts)
		end
	end,

	repl_restart = function(opts)
		return function()
			notebook_use_case.repl_restart(opts)
		end
	end,

	interrupt = function(opts)
		return function()
			notebook_use_case.interrupt(opts)
		end
	end,

	exit = function(opts)
		return function()
			notebook_use_case.exit(opts)
		end
	end,

	clear = function(opts)
		return function()
			notebook_use_case.clear(opts)
		end
	end,

	focus = function(opts)
		return function()
			notebook_use_case.focus(opts)
		end
	end,

	toggle = function(opts)
		return function()
			notebook_use_case.toggle(opts)
		end
	end,

	goto_cell = function(opts)
		return function()
			notebook_use_case.goto_cell(opts)
		end
	end,

	delete_cell = function(opts)
		return function()
			notebook_use_case.delete_cell(opts)
		end
	end,

	insert_cell = function(opts)
		return function()
			notebook_use_case.insert_cell(opts)
		end
	end,

	execute_cell = function(opts)
		return function()
			notebook_use_case.execute_cell(opts)
		end
	end,

	execute_and_goto_next = function(opts)
		return function()
			notebook_use_case.execute_and_goto_next(opts)
		end
	end,

	save = function(opts)
		return function()
			notebook_use_case.save(opts)
		end
	end,

	toggle_output_visibility = function(opts)
		return function()
			notebook_use_case.toggle_output_visibility(opts)
		end
	end,

	reevaluate_cell = function(opts)
		return function()
			notebook_use_case.reevaluate_cell(opts)
		end
	end,
}

return make_controller_logged("notebook", M)
