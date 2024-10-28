local clone = require("domain.utils.table").clone
local linenumber = require("domain.contracts.registry").linenumber()
local statusline = require("domain.contracts.registry").statusline()
local toggler = require("domain.contracts.registry").toggler()
---@return KeyBind[]
return function()
	---@type KeyBind[]
	local statusline_content = {
		{ key = "m", description = "Statusline" },
		{ key = "mT", description = "Toggle", method = statusline.toggle() },
	}

	---@type KeyBind[]
	local numberline_content = {
		{ key = "n", description = "Line-number" },
		{ key = "na", description = "Absolute line number", method = linenumber.toggle({ type = "absolute" }) },
		{ key = "nr", description = "Relative line number", method = linenumber.toggle({ type = "relative" }) },
		{ key = "nv", description = "Visual line number", method = toggler.number() },
	}

	---@type KeyBind[]
	local toggler_content = {
		{ key = "l", description = "Truncate line", method = toggler.wrap() },
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
