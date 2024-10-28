local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("application.ports.registry").buffer()
end

M.add = function()
	local adapter = M.setup()

	adapter.add()
end

M.delete = function()
	local adapter = M.setup()

	adapter.delete()
end

M.close_others = function()
	local adapter = M.setup()

	adapter.close_others()
end

M.list = function()
	local adapter = M.setup()

	adapter.list()
end

M.next = function()
	local adapter = M.setup()

	adapter.next()
end

M.previous = function()
	local adapter = M.setup()

	adapter.previous()
end

M.messages = function()
	local adapter = M.setup()

	adapter.messages()
end

M.reopen = function()
	local adapter = M.setup()

	adapter.reopen()
end

return make_logged("use_cases/buffer", M)
