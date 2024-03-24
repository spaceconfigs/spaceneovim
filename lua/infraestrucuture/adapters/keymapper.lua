local M = {}

local plugin = require("infraestrucuture.plugins.keymapper")

local format_map = function(map)
	return {
		[map.key] = {
			map.method,
			map.description,
			buffer = map.buffer,
			silent = map.silent,
			noremap = map.noremap,
			nowait = map.nowait,
			mode = map.mode,
		},
	}
end

local format_group = function(map)
	return {
		[map.key] = {
			name = map.description,
			buffer = map.buffer,
			silent = map.silent,
			noremap = map.noremap,
			nowait = map.nowait,
			mode = map.mode,
		},
	}
end

M.format = function(map)
	if map.method ~= nil then
		local result = format_map(map)
		return result
	end

	local result = format_group(map)
	return result
end

M.regist = function(map)
	if map.method ~= nil then
		local result = format_map(map)
		-- return plugin.register(result)
		vim.keymap.set(map.mode, map.key, map.method, {
			noremap = map.noremap,
			nowait = map.nowait,
			silent = map.silent,
		})
	end

	local result = format_group(map)
	-- print(vim.inspect(result))
	-- return plugin.register(result)
end

M.regist_all = function(maps)
	for _, map in pairs(maps) do
		M.regist(map)
	end
end

return M
