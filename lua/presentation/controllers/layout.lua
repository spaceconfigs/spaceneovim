local make_controller_logged = require("application.helpers.make_controller_logged")
local layout_usecase = require("application.ports.usecase_registry").layout()

---@type LayoutContract
local M = {
	list = function()
		return function()
			layout_usecase.list()
		end
	end,

	reload = function()
		return function()
			layout_usecase.reload()
		end
	end,

	save = function()
		return function()
			layout_usecase.save()
		end
	end,

	delete = function()
		return function()
			layout_usecase.delete()
		end
	end,

	rename = function()
		return function()
			layout_usecase.rename()
		end
	end,

	previous = function()
		return function()
			layout_usecase.previous()
		end
	end,
}

return make_controller_logged("layout", M)
