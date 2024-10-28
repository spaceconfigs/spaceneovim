local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
	return require("application.ports.adapter_registry").editor()
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

M.setup_jumplist_motions = function()
	local adapter = M.setup()

	adapter.setup_jumplist_motions()
end

---@param buffer number
---@return string
M.current_path = function(buffer)
	local adapter = M.setup()

	return adapter.current_path(buffer)
end

---@param filetype string
M.apply_rules = function(filetype)
	local adapter = M.setup()

	adapter.apply_rules(filetype)
end

return make_logged("usecases/editor", M)
