local clone = require("domain.utils.table").clone
---@param controllers ControllerRegistry
---@return KeyBind[]
return function(controllers)
	local vim = vim

	---@type KeyBind[]
	local selector_content = {
		{ key = "r", description = "Multi selection" },
		{ key = "rq", description = "Quit", method = controllers.selector.quit() },
		{ key = "rm", description = "All selected", method = controllers.selector.all_selected() },
	}

	local result = {}
	local contents = {}
	for _, content in pairs({
		selector_content,
	}) do
		for _, bind in pairs(content) do
			table.insert(contents, bind)
		end
	end

	for _, content in pairs(contents) do
		local bind = clone(content)
		bind.key = "g" .. bind.key
		bind.mode = "n"
		bind.buffer = nil
		bind.silent = true
		bind.noremap = true
		bind.nowait = false
		table.insert(result, bind)
	end

	return result
end
