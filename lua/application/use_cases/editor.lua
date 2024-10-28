local M = {}

M.setup = function()
	return require("infrastructure.adapters.editor")
end

M.drag_down = function(opts)
	local adapter = M.setup()

	adapter.drag_down(opts)
end

M.drag_up = function(opts)
	local adapter = M.setup()

	adapter.drag_up(opts)
end

M.next_paragraph = function()
	local adapter = M.setup()

	adapter.next_paragraph()
end

M.previous_paragraph = function()
	local adapter = M.setup()

	adapter.previous_paragraph()
end

M.paste_before = function()
	local adapter = M.setup()

	adapter.paste_before()
end

M.paste_after = function()
	local adapter = M.setup()

	adapter.paste_after()
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
