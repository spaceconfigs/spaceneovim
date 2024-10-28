local M = {}

local logger_use_case = require("application.use_cases.logger")

M.drag_down = function(opts)
	local message = {
		module = "adapters/editor",
		func = "drag_down",
		opts = opts,
	}
	logger_use_case.debug(message)

	local mode = opts.mode

	if mode == "visual" then
		vim.cmd("m '>+1")
		vim.cmd("normal! gv=gv")
		return
	end

	if mode == "insert" then
		vim.cmd("normal! " .. vim.api.nvim_replace_termcodes("<Esc>", true, false, true))
		vim.cmd("m .+1")
		vim.cmd("normal! ==gi")
		return
	end

	vim.cmd("m .+1")
	vim.cmd("normal! ==")
end

M.drag_up = function(opts)
	local message = {
		module = "adapters/editor",
		func = "drag_up",
		opts = opts,
	}
	logger_use_case.debug(message)

	local mode = opts.mode

	if mode == "visual" then
		vim.cmd("m '<-2")
		vim.cmd("normal! gv=gv")
		return
	end

	if mode == "insert" then
		vim.cmd("normal! " .. vim.api.nvim_replace_termcodes("<Esc>", true, false, true))
		vim.cmd("m .-2")
		vim.cmd("normal! ==gi")
		return
	end

	vim.cmd("m .-2")
	vim.cmd("normal! ==")
end

M.next_paragraph = function()
	local message = {
		module = "adapters/editor",
		func = "next_paragraph",
	}
	logger_use_case.debug(message)

	vim.cmd("normal! }")
end

M.previous_paragraph = function()
	local message = {
		module = "adapters/editor",
		func = "previous_paragraph",
	}
	logger_use_case.debug(message)

	vim.cmd("normal! {")
end

M.paste_before = function()
	local message = {
		module = "adapters/editor",
		func = "paste_before",
	}
	logger_use_case.debug(message)

	vim.cmd("normal! P")
end

M.paste_after = function()
	local message = {
		module = "adapters/editor",
		func = "paste_after",
	}
	logger_use_case.debug(message)

	vim.cmd("normal! p")
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
