local make_logged = require("application.helpers.make_logged")
require("infrastructure.plugins.plugin_registry").notebook()

vim.cmd("MoltenInit shared")

---@type NotebookPort
local M = {
	send_motion = function(opts)
		-- Molten doesn't have send_motion built-in, use visual selection
		vim.cmd("normal! `[v`]")
		vim.cmd("MoltenEvaluateVisual")
	end,
	send_line = function(opts)
		vim.cmd("MoltenEvaluateLine")
	end,
	send_file = function(opts)
		-- Select entire file and evaluate
		vim.cmd("normal! ggVG")
		vim.cmd("MoltenEvaluateVisual")
	end,
	send_until_cursor = function(opts)
		-- Select from beginning to cursor and evaluate
		vim.cmd("normal! ggV")
		vim.cmd("normal! '<,'>MoltenEvaluateVisual")
	end,
	send_mark = function(opts)
		local mark = opts.mark
		-- Evaluate from cursor to mark
		vim.cmd("normal! v'" .. mark)
		vim.cmd("MoltenEvaluateVisual")
	end,
	repl_here = function(opts)
		vim.cmd("MoltenInit")
	end,
	repl_restart = function(opts)
		vim.cmd("MoltenRestart")
	end,
	interrupt = function(opts)
		vim.cmd("MoltenInterrupt")
	end,
	exit = function(opts)
		vim.cmd("MoltenDeinit")
	end,
	clear = function(opts)
		-- Hide output (clear from view, not delete)
		vim.cmd("MoltenHideOutput")
	end,
	focus = function(opts)
		-- Enter the output window
		vim.cmd("MoltenEnterOutput")
	end,
	toggle = function(opts)
		-- Toggle output display by checking if output is shown
		-- This is a simple implementation - could be improved with state tracking
		local has_output = vim.fn.exists("*MoltenShowOutput") == 1
		if has_output then
			vim.cmd("MoltenHideOutput")
		else
			vim.cmd("MoltenShowOutput")
		end
	end,
	goto_cell = function(opts)
		local direction = opts.direction
		if direction == "next" then
			vim.cmd("MoltenNext")
		elseif direction == "prev" then
			vim.cmd("MoltenPrev")
		end
	end,
	delete_cell = function(opts)
		vim.cmd("MoltenDelete")
	end,
	insert_cell = function(opts)
		local position = opts.position
		local row = vim.api.nvim_win_get_cursor(0)[1]

		if position == "below" then
			vim.api.nvim_buf_set_lines(0, row, row, false, { "# %%", "" })
			vim.api.nvim_win_set_cursor(0, { row + 2, 0 })
		elseif position == "above" then
			vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, { "# %%", "" })
		end

		vim.cmd("startinsert")
	end,
	execute_cell = function(opts)
		-- Execute current line or use ReevaluateCell if in a cell
		vim.cmd("MoltenReevaluateCell")
	end,
	execute_and_goto_next = function(opts)
		-- Execute cell and move to next
		vim.cmd("MoltenReevaluateCell")
		vim.cmd("MoltenNext")
	end,
	save = function(opts)
		vim.cmd("MoltenSave")
	end,
	toggle_output_visibility = function(opts)
		local action = opts.action
		if action == "show" then
			vim.cmd("MoltenShowOutput")
		elseif action == "hide" then
			vim.cmd("MoltenHideOutput")
		end
	end,
	reevaluate_cell = function(opts)
		vim.cmd("MoltenReevaluateCell")
	end,
}

return make_logged("adapters/notebook", M)
