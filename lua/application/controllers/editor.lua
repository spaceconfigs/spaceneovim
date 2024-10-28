local M = {}

local logger_use_case = require("application.use_cases.logger")
local editor_use_case = require("application.use_cases.editor")

M.drag = function(opts)
	return function()
		local message = {
			module = "controllers/editor",
			func = "drag",
			opts = opts,
		}
		logger_use_case.debug(message)
		editor_use_case.drag(opts)
	end
end

M.paragraph = function(opts)
	return function()
		local message = {
			module = "controllers/editor",
			func = "paragraph",
			opts = opts,
		}
		logger_use_case.debug(message)
		editor_use_case.paragraph(opts.direction)
	end
end

M.paste = function(opts)
	return function()
		local message = {
			module = "controllers/editor",
			func = "paste",
			opts = opts,
		}
		logger_use_case.debug(message)
		editor_use_case.paste(opts.position)
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
