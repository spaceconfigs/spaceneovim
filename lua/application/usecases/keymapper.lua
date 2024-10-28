---@type KeymapperUseCase
local M

local adapter = require("application.ports.adapter_registry").keymapper()
local logger_usecase = require("application.usecases.logger")
local clone = require("domain.utils.table").clone

M = {
	format = function(opts)
		local map = adapter.format(opts)
		return map
	end,

	register = function(map)
		adapter.register(map)
	end,

	register_all = function(map)
		adapter.register_all(map)
	end,

	create_transient = function(opts)
		local message = {
			module = "usecases/keymapper",
			func = "create_transient",
			opts = opts,
		}
		logger_usecase.debug(message)

		local config = {
			hint = opts.hint or "",
			config = {
				color = opts.color or "pink",
				-- hint = {
				-- 	position = opts.position or "bottom",
				-- },
			},
			mode = opts.mode or "n",
			heads = opts.heads or {},
		}

		return adapter.create_transient(config)
	end,

	show = function(opts)
		adapter.show(opts)
	end,

	set = function(opts)
		adapter.set(opts)
	end,

	unset = function(opts)
		adapter.unset(opts)
	end,

	--- Replace the global `<leader>` menu with a filetype-specific one in the
	--- current buffer. No-op for filetypes that have no menu.
	---
	--- `domain.maps.filetypes` is required here, not at the module header: its map
	--- modules resolve controllers at require time, and this module must stay
	--- loadable before the controller registry is populated.
	register_filetype = function(filetype)
		local filetypes_map = require("domain.maps.filetypes")

		local menu = filetypes_map.menus[filetype]
		if not menu then
			return
		end

		logger_usecase.debug({
			module = "usecases/keymapper",
			func = "register_filetype",
			filetype = filetype,
		})

		local redirect = filetypes_map.redirect()
		redirect.buffer = 0
		redirect.silent = true
		redirect.noremap = true

		local binds = { redirect }

		for _, content in pairs(menu()) do
			local bind = clone(content)
			bind.key = filetypes_map.root .. bind.key
			bind.mode = bind.mode or "n"
			bind.buffer = 0
			bind.silent = true
			bind.noremap = true
			bind.nowait = false
			table.insert(binds, bind)
		end

		adapter.register_all(binds)
	end,
}

return M
