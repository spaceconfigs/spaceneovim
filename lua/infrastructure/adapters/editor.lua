local M = {}

local logger_use_case = require("application.use_cases.logger")

local drag_offsets = {
	down = { visual = "'>+1", normal = ".+1", insert = ".+1" },
	up = { visual = "'<-2", normal = ".-2", insert = ".-2" },
}

M.drag = function(opts)
	local message = {
		module = "adapters/editor",
		func = "drag",
		opts = opts,
	}
	logger_use_case.debug(message)

	local offsets = drag_offsets[opts.direction]
	local mode = opts.mode

	if mode == "visual" then
		vim.cmd("m " .. offsets.visual)
		vim.cmd("normal! gv=gv")
		return
	end

	if mode == "insert" then
		vim.cmd("normal! " .. vim.api.nvim_replace_termcodes("<Esc>", true, false, true))
		vim.cmd("m " .. offsets.insert)
		vim.cmd("normal! ==gi")
		return
	end

	vim.cmd("m " .. offsets.normal)
	vim.cmd("normal! ==")
end

M.paragraph = function(direction)
	local message = {
		module = "adapters/editor",
		func = "paragraph",
		direction = direction,
	}
	logger_use_case.debug(message)

	local commands = { next = "}", previous = "{" }
	vim.cmd("normal! " .. commands[direction])
end

M.paste = function(position)
	local message = {
		module = "adapters/editor",
		func = "paste",
		position = position,
	}
	logger_use_case.debug(message)

	local commands = { before = "P", after = "p" }
	vim.cmd("normal! " .. commands[position])
end

M.delete_word = function()
	local message = {
		module = "adapters/editor",
		func = "delete_word",
	}
	logger_use_case.debug(message)

	local keys = vim.api.nvim_replace_termcodes("<C-w>", true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end

M.terminal_escape = function()
	local message = {
		module = "adapters/editor",
		func = "terminal_escape",
	}
	logger_use_case.debug(message)

	local keys = vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end

M.noop = function()
	local message = {
		module = "adapters/editor",
		func = "noop",
	}
	logger_use_case.debug(message)
end

return M
