---@type FileUseCase
local M
local make_logged = require("application.helpers.make_logged")

local notification_usecase = require("application.usecases.notification")
local file_util = require("application.ports.adapter_registry").file_util()

M = {
	setup = function()
		return require("application.ports.adapter_registry").file()
	end,

	oldfiles = function(opts)
		local adapter = M.setup()

		opts = opts or {}
		opts.cwd_only = opts.cwd_only or false

		adapter.oldfiles(opts)
	end,

	list = function(opts)
		local adapter = M.setup()

		opts = opts or {}
		opts.location = opts.location or "file"
		opts.path = file_util.project(opts.location)
		opts.cwd_only = opts.cwd_only or false

		adapter.list({
			path = opts.path,
			cwd_only = opts.cwd_only,
		})
	end,

	search = function()
		local adapter = M.setup()

		adapter.search({
			path = file_util.path(),
		})
	end,

	search_hover = function()
		local adapter = M.setup()
		local editor = require("application.ports.adapter_registry").editor()

		adapter.search({
			path = editor.current_path(),
			text = editor.cword(),
		})
	end,

	rename = function()
		local adapter = M.setup()
		local editor = require("application.ports.adapter_registry").editor()

		local old_name = editor.current_path()
		local new_name = editor.prompt("New name: ")

		local success, err = os.rename(old_name, new_name)
		if not success then
			notification_usecase.error("Error renaming file: " .. err)
			return
		end

		adapter.rename({ name = new_name })
	end,

	edit_config = function()
		local adapter = M.setup()

		adapter.edit_config()
	end,

	source_config = function()
		local adapter = M.setup()

		adapter.source_config()
	end,

	delete_current = function()
		local adapter = M.setup()

		adapter.delete_current()
	end,

	save = function()
		local adapter = M.setup()

		adapter.save()
	end,

	save_all = function()
		local adapter = M.setup()

		adapter.save_all()
	end,

	copy = function(opts)
		opts = opts or {}
		opts.item = opts.item or "file"
		opts.location = opts.location or "root"
		opts.extensions = opts.extensions or "type"

		local adapter = M.setup()
		local result = adapter.copy(opts)
		notification_usecase.info("Copied " .. result)
	end,
}

return make_logged("usecases/file", M)
