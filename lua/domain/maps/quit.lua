local clone = require("domain.utils.table").clone
local quit = require("domain.contracts.registry").quit()
---@return KeyBind[]
return function()
	---@type KeyBind[]
	local quit_content = {
		{ key = "q", description = "Kill", method = quit.quit({}) },
		{ key = "s", description = "Save and quit", method = quit.quit({ save = true }) },
		{ key = "R", description = "Restart", method = quit.restart() },
	}

	local result = {}
	local contents = {}
	for _, content in pairs({
		quit_content,
	}) do
		for _, bind in pairs(content) do
			table.insert(contents, bind)
		end
	end

	table.insert(result, {
		key = "<leader>q",
		description = "Quit",
		mode = "n",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = false,
	})
	for _, content in pairs(contents) do
		local bind = clone(content)
		bind.key = "<leader>q" .. bind.key
		bind.mode = "n"
		bind.buffer = nil
		bind.silent = true
		bind.noremap = true
		bind.nowait = false
		table.insert(result, bind)
	end

	return result
end
