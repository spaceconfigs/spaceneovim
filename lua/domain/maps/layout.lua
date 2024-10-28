local clone = require("domain.utils.table").clone
---@param controllers ControllerRegistry
---@return KeyBind[]
return function(controllers)
	---@type KeyBind[]
	local layout_content = {
		{ key = "<Tab>", description = "Load previous", method = controllers.layout.previous() },
		{ key = "D", description = "Delete", method = controllers.layout.delete() },
		{ key = "l", description = "List", method = controllers.layout.list() },
		{ key = "L", description = "Reload", method = controllers.layout.reload() },
		{ key = "s", description = "Save", method = controllers.layout.save() },
		{ key = "R", description = "Rename", method = controllers.layout.rename() },
	}

	local result = {}
	local contents = {}
	for _, content in pairs({
		layout_content,
	}) do
		for _, bind in pairs(content) do
			table.insert(contents, bind)
		end
	end

	table.insert(result, {
		key = "<leader>l",
		description = "Layout",
		mode = "n",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = false,
	})
	for _, content in pairs(contents) do
		local bind = clone(content)
		bind.key = "<leader>l" .. bind.key
		bind.mode = "n"
		bind.buffer = nil
		bind.silent = true
		bind.noremap = true
		bind.nowait = false
		table.insert(result, bind)
	end

	return result
end
