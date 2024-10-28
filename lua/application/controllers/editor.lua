local M = {}

local logger_use_case = require("application.use_cases.logger")
local editor_use_case = require("application.use_cases.editor")

M.drag_down = function(opts)
	return function()
		local message = {
			module = "controllers/editor",
			func = "drag_down",
			opts = opts,
		}
		logger_use_case.debug(message)
		editor_use_case.drag_down(opts)
	end
end

M.drag_up = function(opts)
	return function()
		local message = {
			module = "controllers/editor",
			func = "drag_up",
			opts = opts,
		}
		logger_use_case.debug(message)
		editor_use_case.drag_up(opts)
	end
end

M.next_paragraph = function()
	return function()
		local message = {
			module = "controllers/editor",
			func = "next_paragraph",
		}
		logger_use_case.debug(message)
		editor_use_case.next_paragraph()
	end
end

M.previous_paragraph = function()
	return function()
		local message = {
			module = "controllers/editor",
			func = "previous_paragraph",
		}
		logger_use_case.debug(message)
		editor_use_case.previous_paragraph()
	end
end

M.paste_before = function()
	return function()
		local message = {
			module = "controllers/editor",
			func = "paste_before",
		}
		logger_use_case.debug(message)
		editor_use_case.paste_before()
	end
end

M.paste_after = function()
	return function()
		local message = {
			module = "controllers/editor",
			func = "paste_after",
		}
		logger_use_case.debug(message)
		editor_use_case.paste_after()
	end
end

M.delete_word = function()
	return function()
		local message = {
			module = "controllers/editor",
			func = "delete_word",
		}
		logger_use_case.debug(message)
		editor_use_case.delete_word()
	end
end

M.terminal_escape = function()
	return function()
		local message = {
			module = "controllers/editor",
			func = "terminal_escape",
		}
		logger_use_case.debug(message)
		editor_use_case.terminal_escape()
	end
end

M.noop = function()
	return function()
		local message = {
			module = "controllers/editor",
			func = "noop",
		}
		logger_use_case.debug(message)
		editor_use_case.noop()
	end
end

return M
