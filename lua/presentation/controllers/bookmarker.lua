local make_controller_logged = require("application.helpers.make_controller_logged")
local bookmarker_usecase = require("application.ports.usecase_registry").bookmarker()

---@type BookmarkerContract
local M = {
	add = function()
		return function()
			bookmarker_usecase.add()
		end
	end,

	remove = function()
		return function()
			bookmarker_usecase.remove()
		end
	end,

	list = function()
		return function()
			bookmarker_usecase.list()
		end
	end,
}

return make_controller_logged("bookmarker", M)
