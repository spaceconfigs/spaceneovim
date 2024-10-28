local clone = require("domain.utils.table").clone
local diagnostic = require("domain.contracts.registry").diagnostic()
---@return KeyBind[]
return function()
	---@type KeyBind[]
	local maps = {
		{ key = "l", description = "List", method = diagnostic.toggle() },
		{ key = "n", description = "Next", method = diagnostic.show("next") },
		{ key = "p", description = "Previous", method = diagnostic.show("previous") },
		{ key = "x", description = "Show", method = diagnostic.show() },
	}

	local result = {}
	local contents = {}
	for _, content in pairs({
		maps,
	}) do
		for _, bind in pairs(content) do
			table.insert(contents, bind)
		end
	end

	table.insert(result, {
		key = "<leader>e",
		description = "Error",
		mode = "n",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = false,
	})
	for _, content in pairs(contents) do
		local bind = clone(content)
		bind.key = "<leader>e" .. bind.key
		bind.mode = "n"
		bind.buffer = nil
		bind.silent = true
		bind.noremap = true
		bind.nowait = false
		table.insert(result, bind)
	end

	return result
end
