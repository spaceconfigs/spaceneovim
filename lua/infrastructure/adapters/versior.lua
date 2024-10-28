local M = {}

local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.versior")
local gitsigns = plugin.gitsigns
local neogit = plugin.neogit
local snacks = plugin.snacks

M.blame = function(opts)
	if opts.location == "file" then
		return snacks.picker.git_log_line()
	end

	gitsigns.blame_line()
end

M.open = function()
	neogit.open({ kind = "auto" })
end

M.stage_files = function()
	gitsigns.stage_buffer()
end

M.unstage_files = function()
	gitsigns.undo_stage_hunk()
end

M.browse = function()
	snacks.gitbrowse()
end

M.branches = function()
	snacks.picker.git_branches()
end

M.log = function()
	snacks.picker.git_log()
end

return make_logged("adapters/versior", M)
