local plugins = require("infrastructure.plugins.registry").keymapper()
local which_key = plugins.which_key
local hydra = plugins.hydra
local logger_use_case = require("application.use_cases.logger")

local format_map = function(map)
	return {
		map.key,
		map.method,
		desc = map.description,
		buffer = map.buffer,
		silent = map.silent,
		noremap = map.noremap,
		nowait = map.nowait,
		mode = map.mode,
	}
end

local format_group = function(map)
	return {
		map.key,
		group = map.description,
		mode = map.mode,
	}
end

---@type KeymapperPort
local M
M = {
	format = function(map)
		local message = {
			module = "adapters/keymapper",
			func = "format",
			server = map,
		}
		logger_use_case.debug(message)

		if map.method == nil then
			return format_group(map)
		end

		return format_map(map)
	end,
	register = function(map)
		local message = {
			module = "adapters/keymapper",
			func = "register",
			server = map,
		}
		logger_use_case.debug(message)

		local formatted = M.format(map)
		which_key.add(formatted)
	end,
	register_all = function(maps)
		local message = {
			module = "adapters/keymapper",
			func = "regist_all",
			server = maps,
		}
		logger_use_case.debug(message)

		for _, map in pairs(maps) do
			M.register(map)
		end
	end,
	create_transient = function(opts)
		local message = {
			module = "adapters/keymapper",
			func = "create_transient",
			opts = opts,
		}
		logger_use_case.debug(message)

		return hydra(opts)
	end,
	set = function(opts)
		logger_use_case.debug({
			module = "adapters/keymapper",
			func = "set",
			opts = opts,
		})

		vim.keymap.set(opts.mode, opts.key, opts.action, {
			noremap = opts.noremap,
			silent = opts.silent,
		})
	end,
	unset = function(opts)
		logger_use_case.debug({
			module = "adapters/keymapper",
			func = "unset",
			opts = opts,
		})

		vim.api.nvim_del_keymap(opts.mode, opts.key)
	end,
}

return M
