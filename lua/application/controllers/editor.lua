local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local editor_use_case = require("application.use_cases.editor")

M.drag = function(opts)
	return function()
		editor_use_case.drag(opts)
	end
end

M.paragraph = function(opts)
	return function()
		editor_use_case.paragraph(opts.direction)
	end
end

M.paste = function(opts)
	return function()
		editor_use_case.paste(opts.position)
	end
end

M.delete_word = function()
	return function()
		editor_use_case.delete_word()
	end
end

M.terminal_escape = function()
	return function()
		editor_use_case.terminal_escape()
	end
end

M.noop = function()
	return function()
		editor_use_case.noop()
	end
end

return make_controller_logged("editor", M)
