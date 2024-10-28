local M = {}

local logger_use_manage = require("application.use_cases.logger")
require("infrastructure.plugins.notebook")

vim.cmd("MoltenInit shared")

M.send_motion = function(opts)
	local message = {
		module = "adapters/notebook",
		func = "send_motion",
		opts = opts,
	}
	logger_use_manage.debug(message)

	-- Molten doesn't have send_motion built-in, use visual selection
	vim.cmd("normal! `[v`]")
	vim.cmd("MoltenEvaluateVisual")
end

M.send_line = function(opts)
	local message = {
		module = "adapters/notebook",
		func = "send_line",
		opts = opts,
	}
	logger_use_manage.debug(message)

	vim.cmd("MoltenEvaluateLine")
end

M.send_file = function(opts)
	local message = {
		module = "adapters/notebook",
		func = "send_file",
		opts = opts,
	}
	logger_use_manage.debug(message)

	-- Select entire file and evaluate
	vim.cmd("normal! ggVG")
	vim.cmd("MoltenEvaluateVisual")
end

M.send_until_cursor = function(opts)
	local message = {
		module = "adapters/notebook",
		func = "send_until_cursor",
		opts = opts,
	}
	logger_use_manage.debug(message)

	-- Select from beginning to cursor and evaluate
	vim.cmd("normal! ggV")
	vim.cmd("normal! '<,'>MoltenEvaluateVisual")
end

M.send_mark = function(opts)
	local message = {
		module = "adapters/notebook",
		func = "send_mark",
		opts = opts,
	}
	logger_use_manage.debug(message)

	local mark = opts.mark
	-- Evaluate from cursor to mark
	vim.cmd("normal! v'" .. mark)
	vim.cmd("MoltenEvaluateVisual")
end

M.repl_here = function(opts)
	local message = {
		module = "adapters/notebook",
		func = "repl_here",
		opts = opts,
	}
	logger_use_manage.debug(message)

	vim.cmd("MoltenInit")
end

M.repl_restart = function(opts)
	local message = {
		module = "adapters/notebook",
		func = "repl_restart",
		opts = opts,
	}
	logger_use_manage.debug(message)

	vim.cmd("MoltenRestart")
end

M.interrupt = function(opts)
	local message = {
		module = "adapters/notebook",
		func = "interrupt",
		opts = opts,
	}
	logger_use_manage.debug(message)

	vim.cmd("MoltenInterrupt")
end

M.exit = function(opts)
	local message = {
		module = "adapters/notebook",
		func = "exit",
		opts = opts,
	}
	logger_use_manage.debug(message)

	vim.cmd("MoltenDeinit")
end

M.clear = function(opts)
	local message = {
		module = "adapters/notebook",
		func = "clear",
		opts = opts,
	}
	logger_use_manage.debug(message)

	-- Hide output (clear from view, not delete)
	vim.cmd("MoltenHideOutput")
end

M.focus = function(opts)
	local message = {
		module = "adapters/notebook",
		func = "focus",
		opts = opts,
	}
	logger_use_manage.debug(message)

	-- Enter the output window
	vim.cmd("MoltenEnterOutput")
end

M.toggle = function(opts)
	local message = {
		module = "adapters/notebook",
		func = "toggle",
		opts = opts,
	}
	logger_use_manage.debug(message)

	-- Toggle output display by checking if output is shown
	-- This is a simple implementation - could be improved with state tracking
	local has_output = vim.fn.exists("*MoltenShowOutput") == 1
	if has_output then
		vim.cmd("MoltenHideOutput")
	else
		vim.cmd("MoltenShowOutput")
	end
end

M.goto_cell = function(opts)
	local message = {
		module = "adapters/notebook",
		func = "goto_cell",
		opts = opts,
	}
	logger_use_manage.debug(message)

	local direction = opts.direction
	if direction == "next" then
		vim.cmd("MoltenNext")
	elseif direction == "prev" then
		vim.cmd("MoltenPrev")
	end
end

M.delete_cell = function(opts)
	local message = {
		module = "adapters/notebook",
		func = "delete_cell",
		opts = opts,
	}
	logger_use_manage.debug(message)

	vim.cmd("MoltenDelete")
end

M.insert_cell = function(opts)
	local message = {
		module = "adapters/notebook",
		func = "insert_cell",
		opts = opts,
	}
	logger_use_manage.debug(message)

	local position = opts.position
	local row = vim.api.nvim_win_get_cursor(0)[1]

	if position == "below" then
		vim.api.nvim_buf_set_lines(0, row, row, false, { "# %%", "" })
		vim.api.nvim_win_set_cursor(0, { row + 2, 0 })
	elseif position == "above" then
		vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, { "# %%", "" })
	end

	vim.cmd("startinsert")
end

M.execute_cell = function(opts)
	local message = {
		module = "adapters/notebook",
		func = "execute_cell",
		opts = opts,
	}
	logger_use_manage.debug(message)

	-- Execute current line or use ReevaluateCell if in a cell
	vim.cmd("MoltenReevaluateCell")
end

M.execute_and_goto_next = function(opts)
	local message = {
		module = "adapters/notebook",
		func = "execute_and_goto_next",
		opts = opts,
	}
	logger_use_manage.debug(message)

	-- Execute cell and move to next
	vim.cmd("MoltenReevaluateCell")
	vim.cmd("MoltenNext")
end

M.save = function(opts)
	local message = {
		module = "adapters/notebook",
		func = "save",
		opts = opts,
	}
	logger_use_manage.debug(message)

	vim.cmd("MoltenSave")
end

M.toggle_output_visibility = function(opts)
	local message = {
		module = "adapters/notebook",
		func = "toggle_output_visibility",
		opts = opts,
	}
	logger_use_manage.debug(message)

	local action = opts.action
	if action == "show" then
		vim.cmd("MoltenShowOutput")
	elseif action == "hide" then
		vim.cmd("MoltenHideOutput")
	end
end

M.reevaluate_cell = function(opts)
	local message = {
		module = "adapters/notebook",
		func = "reevaluate_cell",
		opts = opts,
	}
	logger_use_manage.debug(message)

	vim.cmd("MoltenReevaluateCell")
end

return M
