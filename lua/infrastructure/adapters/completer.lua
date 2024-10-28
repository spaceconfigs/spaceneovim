local make_logged = require("application.helpers.make_logged")
local plugin = require("infrastructure.plugins.registry").completer()
local blink_cmp = plugin.blink_cmp

---@type CompleterPort
local M = {
  complete = function()
    if blink_cmp.visible() then
      blink_cmp.abort()
    end

    blink_cmp.show()
  end,
}

return make_logged("adapters/completer", M)
