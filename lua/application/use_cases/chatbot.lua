local M = {}

M.setup = function()
	return require("infrastructure.adapters.chatbot")
end

M.toggle = function(opts)
	opts = opts or {}
	opts.provider = opts.provider or "claudecode"

	local adapter = M.setup()

	adapter.toggle(opts)
end

M.edit = function(opts)
	opts = opts or {}
	opts.provider = opts.provider or "claudecode"

	local adapter = M.setup()

	adapter.edit(opts)
end

M.zenmode = function(opts)
	opts = opts or {}
	opts.action = opts.action or "toggle"
	opts.provider = opts.provider or "claudecode"

	local adapter = M.setup()

	adapter.zenmode(opts)
end

M.session = function(opts)
	opts = opts or {}
	opts.action = opts.action or "toggle"
	opts.provider = opts.provider or "claudecode"

	local adapter = M.setup()

	adapter.session(opts)
end

M.send_prompt = function(opts)
	opts = opts or {}
	opts.provider = opts.provider or "claudecode"

	local adapter = M.setup()

	adapter.send_prompt(opts)
end

M.add_file = function(opts)
	opts = opts or {}
	opts.provider = opts.provider or "claudecode"

	local adapter = M.setup()

	adapter.add_file(opts)
end

M.select_model = function(opts)
	opts = opts or {}
	opts.provider = opts.provider or "claudecode"

	local adapter = M.setup()

	adapter.select_model(opts)
end

M.accept_diff = function(opts)
	opts = opts or {}
	opts.provider = opts.provider or "claudecode"

	local adapter = M.setup()

	adapter.accept_diff(opts)
end

M.deny_diff = function(opts)
	opts = opts or {}
	opts.provider = opts.provider or "claudecode"

	local adapter = M.setup()

	adapter.deny_diff(opts)
end

return M
