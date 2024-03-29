local M = {}

local logger_use_manage = require("application.use_cases.logger")
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
	local message = {
		module = "adapters/keymapper",
		func = "format",
		server = map,
	}
	logger_use_manage.debug(message)

	if map.method ~= nil then
		local result = format_map(map)
		return result
	end

	local result = format_group(map)
	return result
end

M.regist = function(map)
	local message = {
		module = "adapters/keymapper",
		func = "regist",
		server = map,
	}
	logger_use_manage.debug(message)

	if map.method ~= nil then
		-- local result = format_map(map)
		-- print(vim.inspect(result))
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
	local message = {
		module = "adapters/keymapper",
		func = "regist_all",
		server = maps,
	}
	logger_use_manage.debug(message)

	for _, map in pairs(maps) do
		M.regist(map)
	end
end

return M
