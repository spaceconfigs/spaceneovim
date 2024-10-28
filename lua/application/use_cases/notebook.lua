local M = {}

local keymapper_use_case = require("application.use_cases.keymapper")

local notebook_transient = nil

M.setup = function()
	return require("infrastructure.adapters.notebook")
end

M.activate_transient = function()
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
			{ "d", function() M.delete_cell() end, { desc = "Delete cell" } },
			{ "i", function() M.insert_cell({ position = "below" }) end, { desc = "Insert cell below" } },
			{ "I", function() M.insert_cell({ position = "above" }) end, { desc = "Insert cell above" } },

			-- Execution (matching Spacemacs RET, C-s)
			{ "<CR>", function() M.execute_and_goto_next() end, { desc = "Execute and goto next" } },
			{ "s", function() M.save() end, { desc = "Save notebook" } },

			-- Output control (matching Spacemacs t for toggle)
			{ "t", function() M.toggle() end, { desc = "Toggle output" } },
			{ "o", function() M.toggle_output_visibility({ action = "show" }) end, { desc = "Show output" } },
			{ "O", function() M.toggle_output_visibility({ action = "hide" }) end, { desc = "Hide output" } },

			-- REPL control
			{ ",", function() M.repl_here() end, { desc = "Init REPL" } },
			{ "x", function() M.exit() end, { desc = "Exit REPL" } },
			{ "R", function() M.repl_restart() end, { desc = "Restart REPL" } },
			{ "z", function() M.interrupt() end, { desc = "Interrupt" } },

			-- Send to REPL
			{ "l", function() M.send_line() end, { desc = "Send line" } },
			{ "m", function() M.send_motion() end, { desc = "Send motion" } },
			{ "f", function() M.send_file() end, { desc = "Send file" } },
			{ "c", function() M.send_until_cursor() end, { desc = "Send until cursor" } },

			{ "<Esc>", nil, { exit = true } },
		},
	})

	notebook_transient:activate()
end

M.send_motion = function(opts)
	opts = opts or {}

	local adapter = M.setup()
	adapter.send_motion(opts)
end

M.send_line = function(opts)
	opts = opts or {}

	local adapter = M.setup()
	adapter.send_line(opts)
end

M.send_file = function(opts)
	opts = opts or {}

	local adapter = M.setup()
	adapter.send_file(opts)
end

M.send_until_cursor = function(opts)
	opts = opts or {}

	local adapter = M.setup()
	adapter.send_until_cursor(opts)
end

M.send_mark = function(opts)
	opts = opts or {}
	opts.mark = opts.mark or "a"

	local adapter = M.setup()
	adapter.send_mark(opts)
end

M.repl_here = function(opts)
	opts = opts or {}

	local adapter = M.setup()
	adapter.repl_here(opts)
end

M.repl_restart = function(opts)
	opts = opts or {}

	local adapter = M.setup()
	adapter.repl_restart(opts)
end

M.interrupt = function(opts)
	opts = opts or {}

	local adapter = M.setup()
	adapter.interrupt(opts)
end

M.exit = function(opts)
	opts = opts or {}

	local adapter = M.setup()
	adapter.exit(opts)
end

M.clear = function(opts)
	opts = opts or {}

	local adapter = M.setup()
	adapter.clear(opts)
end

M.focus = function(opts)
	opts = opts or {}

	local adapter = M.setup()
	adapter.focus(opts)
end

M.toggle = function(opts)
	opts = opts or {}

	local adapter = M.setup()
	adapter.toggle(opts)
end

M.goto_cell = function(opts)
	opts = opts or {}
	opts.direction = opts.direction or "next"

	local adapter = M.setup()
	adapter.goto_cell(opts)
end

M.delete_cell = function(opts)
	opts = opts or {}

	local adapter = M.setup()
	adapter.delete_cell(opts)
end

M.insert_cell = function(opts)
	opts = opts or {}
	opts.position = opts.position or "below"

	local adapter = M.setup()
	adapter.insert_cell(opts)
end

M.execute_cell = function(opts)
	opts = opts or {}

	local adapter = M.setup()
	adapter.execute_cell(opts)
end

M.execute_and_goto_next = function(opts)
	opts = opts or {}

	local adapter = M.setup()
	adapter.execute_and_goto_next(opts)
end

M.save = function(opts)
	opts = opts or {}

	local adapter = M.setup()
	adapter.save(opts)
end

M.toggle_output_visibility = function(opts)
	opts = opts or {}
	opts.action = opts.action or "show"

	local adapter = M.setup()
	adapter.toggle_output_visibility(opts)
end

M.reevaluate_cell = function(opts)
	opts = opts or {}

	local adapter = M.setup()
	adapter.reevaluate_cell(opts)
end

return M
