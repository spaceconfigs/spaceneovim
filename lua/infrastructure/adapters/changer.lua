local make_logged = require("application.helpers.make_logged")
local plugins = require("infrastructure.plugins.changer")
local snacks = plugins.snacks

---@type ChangerPort
local M = {
  list = function()
    snacks.picker.undo()
  end,
}

return make_logged("adapters/changer", M)
