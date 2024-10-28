---@type CommenterUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
	setup = function()
		return require("application.ports.adapter_registry").commenter()
	end,

	toggle_current_line_visual_mode = function()
		local adapter = M.setup()
		local editor = require("application.ports.adapter_registry").editor()

		editor.escape_visual()
		local mode = editor.last_visual_mode()

		adapter.toggle({ mode = mode })
	end,

	toggle_current_line = function()
		local adapter = M.setup()

		adapter.toggle()
	end,
}

return make_logged("usecases/commenter", M)
