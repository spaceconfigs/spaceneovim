---@type ChatbotUseCase
local M
local make_logged = require("application.helpers.make_logged")

M = {
  setup = function()
    return require("application.ports.adapter_registry").chatbot()
  end,

  toggle = function()
    M.setup().toggle()
  end,

  open = function()
    M.setup().open()
  end,

  close = function()
    M.setup().close()
  end,

  send = function(target)
    M.setup().send(target)
  end,

  switch = function()
    M.setup().switch()
  end,

  prompt = function()
    M.setup().prompt()
  end,
}

return make_logged("usecases/chatbot", M)
