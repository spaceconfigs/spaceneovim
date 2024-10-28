local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("infrastructure.adapters.versior")
end

---@param opts? { location?: "file"|"line" }
M.blame = function(opts)
	opts = opts or {}
	opts.location = opts.location or "file"
	local adapter = M.setup()

	adapter.blame(opts)
end

M.open = function()
	local adapter = M.setup()

	adapter.open()
end

M.stage_file = function()
	local adapter = M.setup()

	adapter.stage_files()
end

M.unstage_file = function()
	local adapter = M.setup()

	adapter.unstage_files()
end

M.browse = function()
	local adapter = M.setup()

	adapter.browse()
end

M.branches = function()
	local adapter = M.setup()

	adapter.branches()
end

M.log = function()
	local adapter = M.setup()

	adapter.log()
end

---@param opts? { direction?: "next"|"previous" }
M.jump_file = function(opts)
	opts = opts or {}
	opts.direction = opts.direction or "next"
	local adapter = M.setup()

	adapter.jump_file(opts)
end

return make_logged("use_cases/versior", M)
