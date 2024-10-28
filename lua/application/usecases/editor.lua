---@type EditorUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
	setup = function()
		return require("application.ports.adapter_registry").editor()
	end,

	drag = function(opts)
		opts = opts or {}
		opts.mode = opts.mode or "normal"
		local adapter = M.setup()

		adapter.drag(opts)
	end,

	paragraph = function(direction)
		local adapter = M.setup()

		adapter.paragraph(direction)
	end,

	paste = function(position)
		local adapter = M.setup()

		adapter.paste(position)
	end,

	delete_word = function()
		local adapter = M.setup()

		adapter.delete_word()
	end,

	terminal_escape = function()
		local adapter = M.setup()

		adapter.terminal_escape()
	end,

	noop = function()
		local adapter = M.setup()

		adapter.noop()
	end,

	setup_jumplist_motions = function()
		local adapter = M.setup()

		adapter.setup_jumplist_motions()
	end,

	current_path = function(buffer)
		local adapter = M.setup()

		return adapter.current_path(buffer)
	end,

	start_highlighting = function()
		local adapter = M.setup()

		adapter.start_highlighting()
	end,

	stop_highlighting = function(buffer)
		local adapter = M.setup()

		adapter.stop_highlighting(buffer)
	end,

	apply_rules = function(filetype)
		local adapter = M.setup()

		adapter.apply_rules(filetype)
	end,
}

return make_logged("usecases/editor", M)
