local make_controller_logged = require("application.helpers.make_controller_logged")
local buffer_usecase = require("application.ports.use_case_registry").buffer()

---@type BufferContract
local M = {
	add = function()
		return function()
			buffer_usecase.add()
		end
	end,

	delete = function()
		return function()
			buffer_usecase.delete()
		end
	end,

	close_others = function()
		return function()
			buffer_usecase.close_others()
		end
	end,

	list = function()
		return function()
			buffer_usecase.list()
		end
	end,

	next = function()
		return function()
			buffer_usecase.next()
		end
	end,

	previous = function()
		return function()
			buffer_usecase.previous()
		end
	end,

	messages = function()
		return function()
			buffer_usecase.messages()
		end
	end,

	reopen = function()
		return function()
			buffer_usecase.reopen()
		end
	end,
}

return make_controller_logged("buffer", M)
