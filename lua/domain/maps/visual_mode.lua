---@param controllers ControllerRegistry
---@return KeyBind[]
return function(controllers)
	---@type KeyBind[]
	local jump_content = {
		{
			key = "w",
			description = "Word",
			method = controllers.jumper.words(),
		},
		{
			key = "l",
			description = "Line",
			method = controllers.jumper.lines(),
		},
	}

	return {
		key = "j",
		description = "Jump",
		content = jump_content,
	}
end
