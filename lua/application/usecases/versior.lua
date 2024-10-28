---@type VersiorUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
	setup = function()
		return require("application.ports.adapter_registry").versior()
	end,

	blame = function(opts)
		opts = opts or {}
		opts.location = opts.location or "file"
		local adapter = M.setup()

		adapter.blame(opts)
	end,

	open = function()
		local adapter = M.setup()

		adapter.open()
	end,

	stage_file = function()
		local adapter = M.setup()

		adapter.stage_files()
	end,

	unstage_file = function()
		local adapter = M.setup()

		adapter.unstage_files()
	end,

	browse = function()
		local adapter = M.setup()

		adapter.browse()
	end,

	branches = function()
		local adapter = M.setup()

		adapter.branches()
	end,

	log = function()
		local adapter = M.setup()

		adapter.log()
	end,

	jump_file = function(opts)
		opts = opts or {}
		opts.direction = opts.direction or "next"
		local adapter = M.setup()

		adapter.jump_file(opts)
	end,

	time_machine = function()
		local adapter = M.setup()

		adapter.time_machine()
	end,

	review = function()
		local adapter = M.setup()

		adapter.review()
	end,

	pull_request = function()
		local adapter = M.setup()

		adapter.pull_request()
	end,

	pull_requests = function(opts)
		local adapter = M.setup()

		adapter.pull_requests(opts)
	end,

	reload_pull_request = function()
		local adapter = M.setup()

		adapter.reload_pull_request()
	end,

	notifications = function(opts)
		local adapter = M.setup()

		adapter.notifications(opts)
	end,
}

return make_logged("usecases/versior", M)
