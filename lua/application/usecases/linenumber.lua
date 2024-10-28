---@type LinenumberUseCase
local M
local make_logged = require("application.helpers.make_logged")

local options = { absolute = "number", relative = "relativenumber" }

M = {
	toggle = function(type)
		local editor = require("application.ports.adapter_registry").editor()

		editor.toggle_option(options[type])
	end,
}

return make_logged("usecases/linenumber", M)
