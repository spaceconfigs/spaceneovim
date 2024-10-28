---@type TesterUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
	setup = function()
		return require("application.ports.adapter_registry").tester()
	end,

	toggle = function(opts)
		opts = opts or {}

		local adapter = M.setup()

		adapter.toggle()
	end,

	run = function(opts)
		opts = opts or {}

		local adapter = M.setup()

		adapter.run()
	end,
}

return make_logged("usecases/tester", M)
