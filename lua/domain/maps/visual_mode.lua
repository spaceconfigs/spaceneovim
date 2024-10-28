local jumper = require("domain.contracts.controller_registry").jumper()
---@return KeyBind[]
return function()
	---@type KeyBind[]
	local jump_content = {
		{
			key = "w",
			description = "Word",
			method = jumper.words(),
		},
		{
			key = "l",
			description = "Line",
			method = jumper.lines(),
		},
	}

	return {
		key = "j",
		description = "Jump",
		content = jump_content,
	}
end
