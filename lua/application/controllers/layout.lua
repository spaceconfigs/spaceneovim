local make_controller_logged = require("application.helpers.make_controller_logged")
local layout_use_case = require("application.use_cases.layout")

---@type LayoutContract
local M = {
	list = function()
		return function()
			layout_use_case.list()
		end
	end,

	reload = function()
		return function()
			layout_use_case.reload()
		end
	end,

	save = function()
		return function()
			layout_use_case.save()
		end
	end,

	delete = function()
		return function()
			layout_use_case.delete()
		end
	end,

	rename = function()
		return function()
			layout_use_case.rename()
		end
	end,

	previous = function()
		return function()
			layout_use_case.previous()
		end
	end,
}

return make_controller_logged("layout", M)
