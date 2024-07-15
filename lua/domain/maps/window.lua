local window_use_case = require("application.use_cases.window")
local notification_use_case = require("application.use_cases.notification")

local pop_content = {
	{ key = "p", description = "Pop-up" },
	{ key = "pm", description = "Show history", method = notification_use_case.list },
	{ key = "pP", description = "Dismiss messages", method = notification_use_case.dismiss },
}

local window_content = {
	{ key = "d", description = "Delete", method = ":quit<cr>" },
	{ key = "m", description = "Maximize", method = window_use_case.toggle },
	{ key = "s", description = "Split below", method = ":split | wincmd p<cr>" },
	{ key = "v", description = "Split right", method = ":vsplit | wincmd p<cr>" },
	{ key = "S", description = "Split below", method = ":split<cr>" },
	{ key = "V", description = "Split right", method = ":vsplit<cr>" },
	{ key = "K", description = "Move to up", method = window_use_case.move_far_up },
	{ key = "J", description = "Move to down", method = window_use_case.move_far_down },
	{ key = "H", description = "Move to left", method = window_use_case.move_far_left },
	{ key = "L", description = "Move to right", method = window_use_case.move_far_right },
	{ key = "]", description = "Shrink width", method = window_use_case.shrink_width },
	{ key = "[", description = "Expand width", method = window_use_case.expand_width },
	{ key = "+", description = "Shrink width", method = window_use_case.shrink_height },
	{ key = "-", description = "Expand height", method = window_use_case.expand_height },
	{ key = "=", description = "Balance area", method = window_use_case.balance_area },
}

local result = {}
local contents = {}
for _, content in pairs({
	pop_content,
	window_content,
}) do
	for _, bind in pairs(content) do
		table.insert(contents, bind)
	end
end

table.insert(result, {
	key = "<leader>w",
	description = "Project",
	mode = "n",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
})
for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.key = "<leader>w" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = false
	table.insert(result, bind)
end

return result
