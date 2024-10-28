local clone = require("domain.utils.table").clone
---@param controllers ControllerRegistry
---@return KeyBind[]
return function(controllers)
	---@type KeyBind[]
	local toggler_content = {
		{ key = "s", description = "List themes", method = controllers.theme.list() },
	}

	local result = {}
	local contents = {}
	for _, content in pairs({
		toggler_content,
	}) do
		for _, bind in pairs(content) do
			table.insert(contents, bind)
		end
	end

	table.insert(result, {
		key = "<leader>T",
		description = "UI",
		mode = "n",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = false,
	})

	for _, content in pairs(contents) do
		local bind = clone(content)
		bind.key = "<leader>T" .. bind.key
		bind.mode = "n"
		bind.buffer = nil
		bind.silent = true
		bind.noremap = true
		bind.nowait = false
		table.insert(result, bind)
	end

	return result
end
