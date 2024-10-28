local clone = require("domain.utils.table").clone
local buffer = require("domain.contracts.registry").buffer()
---@return KeyBind[]
return function()
	---@type KeyBind[]
	local buffer_content = {
		{ key = "<C-d>", description = "Close others ([d]elete)", method = buffer.close_others() },
		{ key = "b", description = "Find ([b]uffer)", method = buffer.list() },
		{ key = "d", description = "Close ([d]elete)", method = buffer.delete() },
		{ key = "n", description = "[n]ext", method = buffer.next() },
		{ key = "m", description = "[m]essage buffer", method = buffer.messages() },
		{ key = "p", description = "[p]revious", method = buffer.previous() },
		{ key = "u", description = "Reopen ([u]ndo)", method = buffer.reopen() },
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
