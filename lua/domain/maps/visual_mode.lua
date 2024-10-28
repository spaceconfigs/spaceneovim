local jumper_controller = require("application.controllers.jumper")

---@type KeyBind[]
local jump_content = {
	{
		key = "w",
		description = "Word",
		method = jumper_controller.words(),
	},
	{
		key = "l",
		description = "Line",
		method = jumper_controller.lines(),
	},
}

return {
	key = "j",
	description = "Jump",
	content = jump_content,
}
