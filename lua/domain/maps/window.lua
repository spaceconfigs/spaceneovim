local window_use_case = require("application.use_cases.window")
local notification_use_case = require("application.use_cases.notification")

local center_content = {
	{ key = "c", description = "Center" },
	{ key = "cC", description = "Buffer", method = window_use_case.center },
	-- { key = "C", description = "Dismiss messages", method = notification_use_case.dismiss },
}

local pop_content = {
	{ key = "p", description = "Pop-up" },
	{ key = "pm", description = "Show history", method = notification_use_case.list },
	{ key = "pP", description = "Dismiss messages", method = notification_use_case.dismiss },
}

local window_content = {
	{ key = "d", description = "Delete", method = ":quit<cr>" },
	{ key = "h", description = "Go left", method = window_use_case.go_left },
	{ key = "H", description = "Move to left", method = window_use_case.move_left },
	{ key = "j", description = "Go down", method = window_use_case.go_down },
	{ key = "J", description = "Move down", method = window_use_case.move_down },
	{ key = "k", description = "Go up", method = window_use_case.go_up },
	{ key = "K", description = "Move up", method = window_use_case.move_up },
	{ key = "l", description = "Go left", method = window_use_case.go_right },
	{ key = "L", description = "Move right", method = window_use_case.move_right },
	{ key = "m", description = "Maximize", method = window_use_case.toggle },
	{ key = "s", description = "Split below", method = ":split | wincmd p<cr>" },
	{ key = "v", description = "Split right", method = ":vsplit | wincmd p<cr>" },
	{ key = "t", description = "Dedicate", method = window_use_case.dedicate },
	{ key = "S", description = "Split below", method = ":split<cr>" },
	{ key = "V", description = "Split right", method = ":vsplit<cr>" },
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
	center_content,
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
