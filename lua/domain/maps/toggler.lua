local clone = require("domain.utils.table").clone
---@param controllers ControllerRegistry
---@return KeyBind[]
return function(controllers)
	---@type KeyBind[]
	local statusline_content = {
		{ key = "m", description = "Statusline" },
		{ key = "mT", description = "Toggle", method = controllers.statusline.toggle() },
	}

	---@type KeyBind[]
	local numberline_content = {
		{ key = "n", description = "Line-number" },
		{ key = "na", description = "Absolute line number", method = controllers.linenumber.toggle({ type = "absolute" }) },
		{ key = "nr", description = "Relative line number", method = controllers.linenumber.toggle({ type = "relative" }) },
		{ key = "nv", description = "Visual line number", method = controllers.toggler.number() },
	}

	---@type KeyBind[]
	local toggler_content = {
		{ key = "l", description = "Truncate line", method = controllers.toggler.wrap() },
	}

	local result = {}
	local contents = {}
	for _, content in pairs({
		statusline_content,
		numberline_content,
		toggler_content,
	}) do
		for _, bind in pairs(content) do
			table.insert(contents, bind)
		end
	end

	table.insert(result, {
		key = "<leader>t",
		description = "Toggle",
		mode = "n",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = false,
	})

	for _, content in pairs(contents) do
		local bind = clone(content)
		bind.key = "<leader>t" .. bind.key
		bind.mode = "n"
		bind.buffer = nil
		bind.silent = true
		bind.noremap = true
		bind.nowait = false
		table.insert(result, bind)
	end

	return result
end
