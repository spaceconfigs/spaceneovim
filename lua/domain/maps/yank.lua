local clone = require("domain.utils.table").clone
local jumper = require("domain.contracts.controller_registry").jumper()
---@return KeyBind[]
return function()
	---@type KeyBind[]
	local jump_content = {
		{ key = "r", description = "Remote", method = jumper.remote() },
	}

	local result = {}
	local contents = {}
	for _, content in pairs({
		jump_content,
	}) do
		for _, bind in pairs(content) do
			table.insert(contents, bind)
		end
	end

	table.insert(result, {
		key = "<leader>y",
		description = "Yank",
		mode = "n",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = false,
	})

	for _, content in pairs(contents) do
		local bind = clone(content)

		bind.key = "<leader>y" .. bind.key
		bind.mode = "n"
		bind.buffer = nil
		bind.silent = true
		bind.noremap = true
		bind.nowait = false

		table.insert(result, clone(bind))
	end

	return result
end
