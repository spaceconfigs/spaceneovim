local M = {}

local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.file")
local snacks = plugin.snacks

M.find = function(opts)
  snacks.picker.commands()
end
return make_logged("adapters/commander", M)
