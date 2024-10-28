local make_controller_logged = require("application.helpers.make_controller_logged")
local chatbot_usecase = require("application.ports.usecase_registry").chatbot()

---@type ChatbotContract
local M = {
  toggle = function()
    return function()
      chatbot_usecase.toggle()
    end
  end,

  open = function()
    return function()
      chatbot_usecase.open()
    end
  end,

  close = function()
    return function()
      chatbot_usecase.close()
    end
  end,

  send = function(target)
    return function()
      chatbot_usecase.send(target)
    end
  end,

  switch = function()
    return function()
      chatbot_usecase.switch()
    end
  end,
}

return make_controller_logged("chatbot", M)
