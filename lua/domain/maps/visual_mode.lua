local jumper_use_case = require("application.use_cases.jumper")

local jump_content = {
	{
		key = "w",
		description = "Word",
		method = jumper_use_case.words,
	},
	{
		key = "l",
		description = "Line",
		method = jumper_use_case.lines,
	},
}

return {
	key = "j",
	description = "Jump",
	content = jump_content,
}
