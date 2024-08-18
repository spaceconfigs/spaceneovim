local M = {}

local logger_use_manage = require("application.use_cases.logger")
local file = require("infraestrucuture.plugins.file")
local harpoon = require("infraestrucuture.plugins.harpoon")
file.telescope.load_extension("harpoon")
harpoon.ui.toggle_quick_menu = telescope.extensions.harpoon.marks

M.add = function()
	local message = {
		module = "adapters/add",
		func = "list",
	}
	logger_use_manage.debug(message)

	harpoon.mark.add_file()
end

M.remove = function()
	local message = {
		module = "adapters/remove",
		func = "list",
	}
	logger_use_manage.debug(message)

	harpoon.mark.rm_file()
end

M.remove_all = function()
	local message = {
		module = "adapters/remove_all",
		func = "list",
	}
	logger_use_manage.debug(message)

	harpoon.mark.clear_all()
end

M.list = function()
	local message = {
		module = "adapters/list",
		func = "list",
	}
	logger_use_manage.debug(message)

	harpoon.ui.toggle_quick_menu()
end

return M
