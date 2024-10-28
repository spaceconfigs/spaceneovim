local make_controller_logged = require("application.helpers.make_controller_logged")
local editor_use_case = require("application.use_cases.editor")

---@type EditorContract
local M = {
	drag = function(opts)
		return function()
			editor_use_case.drag(opts)
		end
	end,

	paragraph = function(opts)
		return function()
			editor_use_case.paragraph(opts.direction)
		end
	end,

	paste = function(opts)
		return function()
			editor_use_case.paste(opts.position)
		end
	end,

	delete_word = function()
		return function()
			editor_use_case.delete_word()
		end
	end,

	terminal_escape = function()
		return function()
			editor_use_case.terminal_escape()
		end
	end,

	noop = function()
		return function()
			editor_use_case.noop()
		end
	end,
}

return make_controller_logged("editor", M)
