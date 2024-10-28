local clone = require("domain.utils.table").clone
---@param controllers ControllerRegistry
---@return KeyBind[]
return function(controllers)
	---@type KeyBind[]
	local fold_content = {
		{ key = ".", description = "Fold" },
		{ key = ".a", description = "Toggle", method = controllers.fold.fold({ action = "toggle", location = "cursor" }) },
		{ key = ".c", description = "Close", method = controllers.fold.fold({ action = "close", location = "cursor" }) },
		{ key = ".o", description = "Open", method = controllers.fold.fold({ action = "open", location = "cursor" }) },
		{ key = ".m", description = "Close All", method = controllers.fold.fold({ action = "close", location = "all" }) },
		{ key = ".r", description = "Open All", method = controllers.fold.fold({ action = "open", location = "all" }) },
	}

	---@type KeyBind[]
	local frame_content = {
		{ key = "f", description = "Zoom frame" },
		{ key = "f+", description = "In", method = controllers.zoom.change({ delta = 1 }) },
		{ key = "f-", description = "Out", method = controllers.zoom.change({ delta = -1 }) },
	}
	local result = {}
	local contents = {}

	for _, content in pairs({
		fold_content,
		frame_content,
	}) do
		for _, bind in pairs(content) do
			table.insert(contents, bind)
		end
	end

	table.insert(result, {
		key = "<leader>z",
		description = "Zoom",
		mode = "n",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = false,
	})

	for _, content in pairs(contents) do
		local bind = clone(content)
		bind.key = "<leader>z" .. bind.key
		bind.mode = "n"
		bind.buffer = nil
		bind.silent = true
		bind.noremap = true
		bind.nowait = false
		table.insert(result, bind)
	end

	return result
end
