local clone = require("domain.utils.table").clone
local jumper = require("domain.contracts.registry").jumper()
---@return KeyBind[]
return function()
	---@type KeyBind[]
	local jump_content = {
		{ key = "j", mode={"n", "v" }, description = "Timer", method = jumper.timer() },
		{ key = "w", mode={"n", "v" }, description = "Word", method = jumper.words() },
		{ key = "l", mode={"n", "v" }, description = "Line", method = jumper.lines() },
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
		key = "<leader>j",
		description = "Jump",
		mode = { "n", "v" },
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = false,
	})

	for _, content in pairs(contents) do
		local bind = clone(content)
		bind.key = "<leader>j" .. bind.key
		bind.mode = bind.mode or "n"
		bind.buffer = nil
		bind.silent = true
		bind.noremap = true
		bind.nowait = false
		table.insert(result, bind)
	end

	return result
end
