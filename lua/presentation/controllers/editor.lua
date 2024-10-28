local make_controller_logged = require("application.helpers.make_controller_logged")
local editor_usecase = require("application.ports.use_case_registry").editor()

---@type EditorContract
local M = {
	drag = function(opts)
		return function()
			editor_usecase.drag(opts)
		end
	end,

	paragraph = function(opts)
		return function()
			editor_usecase.paragraph(opts.direction)
		end
	end,

	paste = function(opts)
		return function()
			editor_usecase.paste(opts.position)
		end
	end,

	delete_word = function()
		return function()
			editor_usecase.delete_word()
		end
	end,

	terminal_escape = function()
		return function()
			editor_usecase.terminal_escape()
		end
	end,

	noop = function()
		return function()
			editor_usecase.noop()
		end
	end,
}

return make_controller_logged("editor", M)
