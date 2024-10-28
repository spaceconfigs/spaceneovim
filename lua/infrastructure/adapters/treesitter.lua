local make_logged = require("application.helpers.make_logged")

---@type TreesitterPort
local M = {
  setup = function()
    require("infrastructure.plugins.plugin_registry").treesitter()
  end,
}

return make_logged("adapters/treesitter", M)
