local M = {}

local logger_use_case = require("application.use_cases.logger")
local keymapper_use_case = require("application.use_cases.keymapper")

local notebook_transient = nil

M.setup = function()
	return require("infrastructure.adapters.notebook")
end

M.activate_transient = function()
	local message = {
		module = "use_cases/notebook",
		func = "activate_transient",
	}
	logger_use_case.debug(message)
	M.setup()

	if notebook_transient ~= nil then
		return notebook_transient:activate()
	end

	notebook_transient = keymapper_use_case.create_transient({
		hint = [[
      Cell Operations:       Execution:
      _d_: Delete cell       _<CR>_: Execute & next
      _i_: Insert below      _s_: Save
      _I_: Insert above

      REPL Control:        Send to REPL:          Output:
      _,_: Init REPL       _l_: Line              _t_: Toggle output
      _x_: Exit REPL       _m_: Motion            _o_: Show output
      _R_: Restart         _f_: File              _O_: Hide output
      _z_: Interrupt       _c_: Cursor

      _<Esc>_: exit
      ]],
		heads = {
			-- Cell operations (matching Spacemacs d, i, I, y, p, u)
			{ "d", M.delete_cell(), { desc = "Delete cell" } },
			{ "i", M.insert_cell({ position = "below" }), { desc = "Insert cell below" } },
			{ "I", M.insert_cell({ position = "above" }), { desc = "Insert cell above" } },

			-- Execution (matching Spacemacs RET, C-s)
			{ "<CR>", M.execute_and_goto_next(), { desc = "Execute and goto next" } },
			{ "s", M.save(), { desc = "Save notebook" } },

			-- Output control (matching Spacemacs t for toggle)
			{ "t", M.toggle(), { desc = "Toggle output" } },
			{ "o", M.toggle_output_visibility({ action = "show" }), { desc = "Show output" } },
			{ "O", M.toggle_output_visibility({ action = "hide" }), { desc = "Hide output" } },

			-- REPL control
			{ ",", M.repl_here(), { desc = "Init REPL" } },
			{ "x", M.exit(), { desc = "Exit REPL" } },
			{ "R", M.repl_restart(), { desc = "Restart REPL" } },
			{ "z", M.interrupt(), { desc = "Interrupt" } },

			-- Send to REPL
			{ "l", M.send_line(), { desc = "Send line" } },
			{ "m", M.send_motion(), { desc = "Send motion" } },
			{ "f", M.send_file(), { desc = "Send file" } },
			{ "c", M.send_until_cursor(), { desc = "Send until cursor" } },

			{ "<Esc>", nil, { exit = true } },
		},
	})

	notebook_transient:activate()
end

M.send_motion = function(opts)
	return function()
		opts = opts or {}

		local message = {
			module = "use_cases/notebook",
			func = "send_motion",
			opts = opts,
		}
		logger_use_case.debug(message)

		local adapter = M.setup()
		adapter.send_motion(opts)
	end
end

M.send_line = function(opts)
	return function()
		opts = opts or {}

		local message = {
			module = "use_cases/notebook",
			func = "send_line",
			opts = opts,
		}
		logger_use_case.debug(message)

		local adapter = M.setup()
		adapter.send_line(opts)
	end
end

M.send_file = function(opts)
	return function()
		opts = opts or {}

		local message = {
			module = "use_cases/notebook",
			func = "send_file",
			opts = opts,
		}
		logger_use_case.debug(message)

		local adapter = M.setup()
		adapter.send_file(opts)
	end
end

M.send_until_cursor = function(opts)
	return function()
		opts = opts or {}

		local message = {
			module = "use_cases/notebook",
			func = "send_until_cursor",
			opts = opts,
		}
		logger_use_case.debug(message)

		local adapter = M.setup()
		adapter.send_until_cursor(opts)
	end
end

M.send_mark = function(opts)
	return function()
		opts = opts or {}
		opts.mark = opts.mark or "a"

		local message = {
			module = "use_cases/notebook",
			func = "send_mark",
			opts = opts,
		}
		logger_use_case.debug(message)

		local adapter = M.setup()
		adapter.send_mark(opts)
	end
end

M.repl_here = function(opts)
	return function()
		opts = opts or {}

		local message = {
			module = "use_cases/notebook",
			func = "repl_here",
			opts = opts,
		}
		logger_use_case.debug(message)

		local adapter = M.setup()
		adapter.repl_here(opts)
	end
end

M.repl_restart = function(opts)
	return function()
		opts = opts or {}

		local message = {
			module = "use_cases/notebook",
			func = "repl_restart",
			opts = opts,
		}
		logger_use_case.debug(message)

		local adapter = M.setup()
		adapter.repl_restart(opts)
	end
end

M.interrupt = function(opts)
	return function()
		opts = opts or {}

		local message = {
			module = "use_cases/notebook",
			func = "interrupt",
			opts = opts,
		}
		logger_use_case.debug(message)

		local adapter = M.setup()
		adapter.interrupt(opts)
	end
end

M.exit = function(opts)
	return function()
		opts = opts or {}

		local message = {
			module = "use_cases/notebook",
			func = "exit",
			opts = opts,
		}
		logger_use_case.debug(message)

		local adapter = M.setup()
		adapter.exit(opts)
	end
end

M.clear = function(opts)
	return function()
		opts = opts or {}

		local message = {
			module = "use_cases/notebook",
			func = "clear",
			opts = opts,
		}
		logger_use_case.debug(message)

		local adapter = M.setup()
		adapter.clear(opts)
	end
end

M.focus = function(opts)
	return function()
		opts = opts or {}

		local message = {
			module = "use_cases/notebook",
			func = "focus",
			opts = opts,
		}
		logger_use_case.debug(message)

		local adapter = M.setup()
		adapter.focus(opts)
	end
end

M.toggle = function(opts)
	return function()
		opts = opts or {}

		local message = {
			module = "use_cases/notebook",
			func = "toggle",
			opts = opts,
		}
		logger_use_case.debug(message)

		local adapter = M.setup()
		adapter.toggle(opts)
	end
end

M.goto_cell = function(opts)
	return function()
		opts = opts or {}
		opts.direction = opts.direction or "next"

		local message = {
			module = "use_cases/notebook",
			func = "goto_cell",
			opts = opts,
		}
		logger_use_case.debug(message)

		local adapter = M.setup()
		adapter.goto_cell(opts)
	end
end

M.delete_cell = function(opts)
	return function()
		opts = opts or {}

		local message = {
			module = "use_cases/notebook",
			func = "delete_cell",
			opts = opts,
		}
		logger_use_case.debug(message)

		local adapter = M.setup()
		adapter.delete_cell(opts)
	end
end

M.insert_cell = function(opts)
	return function()
		opts = opts or {}
		opts.position = opts.position or "below"

		local message = {
			module = "use_cases/notebook",
			func = "insert_cell",
			opts = opts,
		}
		logger_use_case.debug(message)

		local adapter = M.setup()
		adapter.insert_cell(opts)
	end
end

M.execute_cell = function(opts)
	return function()
		opts = opts or {}

		local message = {
			module = "use_cases/notebook",
			func = "execute_cell",
			opts = opts,
		}
		logger_use_case.debug(message)

		local adapter = M.setup()
		adapter.execute_cell(opts)
	end
end

M.execute_and_goto_next = function(opts)
	return function()
		opts = opts or {}

		local message = {
			module = "use_cases/notebook",
			func = "execute_and_goto_next",
			opts = opts,
		}
		logger_use_case.debug(message)

		local adapter = M.setup()
		adapter.execute_and_goto_next(opts)
	end
end

M.save = function(opts)
	return function()
		opts = opts or {}

		local message = {
			module = "use_cases/notebook",
			func = "save",
			opts = opts,
		}
		logger_use_case.debug(message)

		local adapter = M.setup()
		adapter.save(opts)
	end
end

M.toggle_output_visibility = function(opts)
	return function()
		opts = opts or {}
		opts.action = opts.action or "show"

		local message = {
			module = "use_cases/notebook",
			func = "toggle_output_visibility",
			opts = opts,
		}
		logger_use_case.debug(message)

		local adapter = M.setup()
		adapter.toggle_output_visibility(opts)
	end
end

M.reevaluate_cell = function(opts)
	return function()
		opts = opts or {}

		local message = {
			module = "use_cases/notebook",
			func = "reevaluate_cell",
			opts = opts,
		}
		logger_use_case.debug(message)

		local adapter = M.setup()
		adapter.reevaluate_cell(opts)
	end
end

return M
