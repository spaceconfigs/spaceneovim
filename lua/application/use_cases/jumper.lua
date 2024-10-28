local M = {}

M.setup = function()
	return require("infrastructure.adapters.jumper")
end

M.timer = function(options)
	local adapter = M.setup()
	options = options or {}

	adapter.timer(options)
end

M.words = function()
	local adapter = M.setup()

	adapter.words()
end

M.lines = function()
	local adapter = M.setup()

	adapter.lines()
end

M.remote = function()
	local adapter = M.setup()

	adapter.remote()
end
return M
