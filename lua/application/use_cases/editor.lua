local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("infrastructure.adapters.editor")
end

---@param opts? { direction?: "up"|"down", mode?: "normal"|"insert"|"visual" }
M.drag = function(opts)
	opts = opts or {}
	opts.mode = opts.mode or "normal"
	local adapter = M.setup()

	adapter.drag(opts)
end

---@param direction "next"|"previous"
M.paragraph = function(direction)
	local adapter = M.setup()

	adapter.paragraph(direction)
end

---@param position "before"|"after"
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

return make_logged("use_cases/editor", M)
