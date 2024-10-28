local make_controller_logged = require("application.helpers.make_controller_logged")
local buffer_use_case = require("application.ports.use_case_registry").buffer()

---@type BufferContract
local M = {
	add = function()
		return function()
			buffer_use_case.add()
		end
	end,

	delete = function()
		return function()
			buffer_use_case.delete()
		end
	end,

	close_others = function()
		return function()
			buffer_use_case.close_others()
		end
	end,

	list = function()
		return function()
			buffer_use_case.list()
		end
	end,

	next = function()
		return function()
			buffer_use_case.next()
		end
	end,

	previous = function()
		return function()
			buffer_use_case.previous()
		end
	end,

	messages = function()
		return function()
			buffer_use_case.messages()
		end
	end,

	reopen = function()
		return function()
			buffer_use_case.reopen()
		end
	end,
}

return make_controller_logged("buffer", M)
