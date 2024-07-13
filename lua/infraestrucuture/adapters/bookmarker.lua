local M = {}

local logger_use_manage = require("application.use_cases.logger")

local require_bookmarker = function()
	local telescope = require("infraestrucuture.plugins.file")
	local bookmarker = require("infraestrucuture.plugins.bookmarker")
	telescope.load_extension("harpoon")
	bookmarker.ui.toggle_quick_menu = telescope.extensions.harpoon.marks

	return bookmarker
end

M.add = function()
	local message = {
		module = "adapters/add",
		func = "list",
	}
	logger_use_manage.debug(message)

	local bookmarker = require_bookmarker()
	bookmarker.mark.add_file()
end

M.remove = function()
	local message = {
		module = "adapters/remove",
		func = "list",
	}
	logger_use_manage.debug(message)

	local bookmarker = require_bookmarker()
	bookmarker.mark.rm_file()
end

M.remove_all = function()
	local message = {
		module = "adapters/remove_all",
		func = "list",
	}
	logger_use_manage.debug(message)

	local bookmarker = require_bookmarker()
	bookmarker.mark.clear_all()
end

M.list = function()
	local message = {
		module = "adapters/list",
		func = "list",
	}
	logger_use_manage.debug(message)

	local bookmarker = require_bookmarker()
	bookmarker.ui.toggle_quick_menu()
end

return M
