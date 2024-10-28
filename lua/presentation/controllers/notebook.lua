local make_controller_logged = require("application.helpers.make_controller_logged")
local notebook_usecase = require("application.ports.use_case_registry").notebook()

---@type NotebookContract
local M = {
	activate_transient = function()
		return function()
			notebook_usecase.activate_transient()
		end
	end,

	send_motion = function(opts)
		return function()
			notebook_usecase.send_motion(opts)
		end
	end,

	send_line = function(opts)
		return function()
			notebook_usecase.send_line(opts)
		end
	end,

	send_file = function(opts)
		return function()
			notebook_usecase.send_file(opts)
		end
	end,

	send_until_cursor = function(opts)
		return function()
			notebook_usecase.send_until_cursor(opts)
		end
	end,

	send_mark = function(opts)
		return function()
			notebook_usecase.send_mark(opts)
		end
	end,

	repl_here = function(opts)
		return function()
			notebook_usecase.repl_here(opts)
		end
	end,

	repl_restart = function(opts)
		return function()
			notebook_usecase.repl_restart(opts)
		end
	end,

	interrupt = function(opts)
		return function()
			notebook_usecase.interrupt(opts)
		end
	end,

	exit = function(opts)
		return function()
			notebook_usecase.exit(opts)
		end
	end,

	clear = function(opts)
		return function()
			notebook_usecase.clear(opts)
		end
	end,

	focus = function(opts)
		return function()
			notebook_usecase.focus(opts)
		end
	end,

	toggle = function(opts)
		return function()
			notebook_usecase.toggle(opts)
		end
	end,

	goto_cell = function(opts)
		return function()
			notebook_usecase.goto_cell(opts)
		end
	end,

	delete_cell = function(opts)
		return function()
			notebook_usecase.delete_cell(opts)
		end
	end,

	insert_cell = function(opts)
		return function()
			notebook_usecase.insert_cell(opts)
		end
	end,

	execute_cell = function(opts)
		return function()
			notebook_usecase.execute_cell(opts)
		end
	end,

	execute_and_goto_next = function(opts)
		return function()
			notebook_usecase.execute_and_goto_next(opts)
		end
	end,

	save = function(opts)
		return function()
			notebook_usecase.save(opts)
		end
	end,

	toggle_output_visibility = function(opts)
		return function()
			notebook_usecase.toggle_output_visibility(opts)
		end
	end,

	reevaluate_cell = function(opts)
		return function()
			notebook_usecase.reevaluate_cell(opts)
		end
	end,
}

return make_controller_logged("notebook", M)
