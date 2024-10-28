local M = {}

M.setup = function()
	return require("infrastructure.adapters.editor")
end

M.drag = function(opts)
	opts = opts or {}
	opts.mode = opts.mode or "normal"
	local adapter = M.setup()

	adapter.drag(opts)
end

M.paragraph = function(direction)
	local adapter = M.setup()

	adapter.paragraph(direction)
end

M.paste = function(position)
	local adapter = M.setup()

	adapter.paste(position)
end

M.delete_word = function()
	local adapter = M.setup()

	adapter.delete_word()
end

M.terminal_escape = function()
	local adapter = M.setup()

	adapter.terminal_escape()
end

M.noop = function()
	local adapter = M.setup()

	adapter.noop()
end

return M
