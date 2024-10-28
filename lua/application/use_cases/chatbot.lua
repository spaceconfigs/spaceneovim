local M = {}

M.setup = function()
	return require("infrastructure.adapters.chatbot")
end

M.toggle = function(opts)
	opts = opts or {}
	opts.provider = opts.provider or "avante"

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

M.send_prompt = function()
	local adapter = M.setup()

	adapter.send_prompt()
end

M.add_file = function()
	local adapter = M.setup()

	adapter.add_file()
end

M.select_model = function()
	local adapter = M.setup()

	adapter.select_model()
end

M.accept_diff = function()
	local adapter = M.setup()

	adapter.accept_diff()
end

M.deny_diff = function()
	local adapter = M.setup()

	adapter.deny_diff()
end

return M
