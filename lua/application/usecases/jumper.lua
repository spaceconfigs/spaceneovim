---@type JumperUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
	setup = function()
		return require("application.ports.adapter_registry").jumper()
	end,

	timer = function(options)
		local adapter = M.setup()
		options = options or {}

		adapter.timer(options)
	end,

	words = function()
		local adapter = M.setup()

		adapter.words()
	end,

	lines = function()
		local adapter = M.setup()

		adapter.lines()
	end,

	remote = function()
		local adapter = M.setup()

		adapter.remote()
	end,
}
return make_logged("usecases/jumper", M)
