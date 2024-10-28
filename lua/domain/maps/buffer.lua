local clone = require("domain.utils.table").clone
local buffer = require("domain.contracts.controller_registry").buffer()
local keymapper = require("domain.contracts.controller_registry").keymapper()
---@return KeyBind[]
return function()
	---@type KeyBind[]
	local buffer_content = {
		{ key = ".", description = "Transient", method = keymapper.activate_transient({ keys = "<leader>b" }) },
		{ key = "<C-d>", description = "Close others (delete)", method = buffer.close_others() },
		{ key = "b", description = "Find (buffer)", method = buffer.list() },
		{ key = "d", description = "Close (delete)", method = buffer.delete() },
		{ key = "n", description = "Next", method = buffer.next() },
		{ key = "m", description = "Message buffer", method = buffer.messages() },
		{ key = "p", description = "Previous", method = buffer.previous() },
		{ key = "u", description = "Reopen (undo)", method = buffer.reopen() },
	}

	local result = {}
	local contents = {}
	for _, content in pairs({
		buffer_content,
	}) do
		for _, bind in pairs(content) do
			table.insert(contents, bind)
		end
	end

	table.insert(result, {
		key = "<leader>b",
		description = "Buffer",
		mode = "n",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = false,
	})
	for _, content in pairs(contents) do
		local bind = clone(content)
		bind.key = "<leader>b" .. bind.key
		bind.mode = "n"
		bind.buffer = nil
		bind.silent = true
		bind.noremap = true
		bind.nowait = false
		table.insert(result, bind)
	end

	return result
end
