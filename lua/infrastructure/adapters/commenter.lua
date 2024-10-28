local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.commenter")

---@type CommenterAdapter
local M = {
  toggle = function(opts)
	local mode = opts and opts.mode or nil
	plugin.api.toggle.linewise(mode)
  end,
}

return make_logged("adapters/commenter", M)
