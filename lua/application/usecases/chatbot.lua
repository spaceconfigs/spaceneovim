local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
  return require("application.ports.adapter_registry").chatbot()
end

M.toggle = function()
  M.setup().toggle()
end

M.open = function()
  M.setup().open()
end

M.close = function()
  M.setup().close()
end

M.send = function(target)
  M.setup().send(target)
end

M.switch = function()
  M.setup().switch()
end

return make_logged("usecases/chatbot", M)
