local plugins = require("infrastructure.plugins.plugin_registry").keymapper()
local which_key = plugins.which_key
local hydra = plugins.hydra
local logger_usecase = require("application.usecases.logger")

-- Transient (loop) mode colour ----------------------------------------------
-- which-key fires no event when it enters/leaves transient (loop) mode, so we
-- recolour the popup ourselves on entry and restore it when the loop's `wk`
-- float closes. The float links its border/title to `WhichKeyBorder`/
-- `WhichKeyTitle` (see which-key/win.lua) and reuses the same window across
-- loop iterations, so re-linking those groups recolours the live popup. A
-- WinClosed on the reused `wk` float is a reliable "loop ended" signal.
local LOOP_HL = { WhichKeyBorder = "WhichKeyLoopBorder", WhichKeyTitle = "WhichKeyLoopTitle" }
local loop_active = false
local loop_saved = {}

-- Defaults; `default = true` lets a colorscheme or user override them freely.
vim.api.nvim_set_hl(0, "WhichKeyLoopBorder", { link = "DiagnosticError", default = true })
vim.api.nvim_set_hl(0, "WhichKeyLoopTitle", { link = "DiagnosticError", default = true })

local function enter_loop()
	if loop_active then
		return
	end
	loop_active = true

	for group, loop_group in pairs(LOOP_HL) do
		loop_saved[group] = vim.api.nvim_get_hl(0, { name = group, link = true })
		vim.api.nvim_set_hl(0, group, { link = loop_group })
	end
end

local function exit_loop()
	if not loop_active then
		return
	end
	loop_active = false

	for group, saved in pairs(loop_saved) do
		vim.api.nvim_set_hl(0, group, saved)
	end
	loop_saved = {}
end

vim.api.nvim_create_autocmd("WinClosed", {
	group = vim.api.nvim_create_augroup("wk-loop-indicator", { clear = true }),
	callback = function(ev)
		if not loop_active then
			return
		end

		local win = tonumber(ev.match)
		local ok, buf = pcall(vim.api.nvim_win_get_buf, win)
		if ok and vim.bo[buf].filetype == "wk" then
			exit_loop()
		end
	end,
})

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
		hidden = map.hidden,
	}
end

local format_group = function(map)
	return {
		map.key,
		group = map.description,
		mode = map.mode,
		hidden = map.hidden,
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
		logger_usecase.debug(message)

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
		logger_usecase.debug(message)

		local formatted = M.format(map)
		which_key.add(formatted)
	end,
	register_all = function(maps)
		local message = {
			module = "adapters/keymapper",
			func = "regist_all",
			server = maps,
		}
		logger_usecase.debug(message)

		local formatted = {}
		for _, map in pairs(maps) do
			table.insert(formatted, M.format(map))
		end

		which_key.add(formatted)
	end,
	show = function(opts)
		logger_usecase.debug({
			module = "adapters/keymapper",
			func = "show",
			opts = opts,
		})

		if opts.loop then
			enter_loop()
		else
			exit_loop()
		end

		which_key.show({
			keys = opts.keys,
			loop = opts.loop,
		})
	end,
	create_transient = function(opts)
		local message = {
			module = "adapters/keymapper",
			func = "create_transient",
			opts = opts,
		}
		logger_usecase.debug(message)

		return hydra(opts)
	end,
	set = function(opts)
		logger_usecase.debug({
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
		logger_usecase.debug({
			module = "adapters/keymapper",
			func = "unset",
			opts = opts,
		})

		vim.api.nvim_del_keymap(opts.mode, opts.key)
	end,
}

return M
