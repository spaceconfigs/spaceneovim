local make_controller_logged = require("application.helpers.make_controller_logged")
local chatbot_usecase = require("application.ports.usecase_registry").chatbot()

---@type ChatbotContract
local M = {
  toggle = function()
    return function()
      chatbot_usecase.toggle()
    end
  end,

  focus = function()
    return function()
      chatbot_usecase.focus()
    end
  end,

  send = function()
    return function()
      chatbot_usecase.send()
    end
  end,

  add_buffer = function()
    return function()
      chatbot_usecase.add_buffer()
    end
  end,

  add_word = function()
    return function()
      chatbot_usecase.add_word()
    end
  end,

  add_selection = function()
    return function()
      chatbot_usecase.add_selection()
    end
  end,

  add_file = function()
    return function()
      chatbot_usecase.add_file()
    end
  end,

  add = function()
    return function()
      chatbot_usecase.add()
    end
  end,

  select_model = function()
    return function()
      chatbot_usecase.select_model()
    end
  end,

  diff_accept = function()
    return function()
      chatbot_usecase.diff_accept()
    end
  end,

  diff_deny = function()
    return function()
      chatbot_usecase.diff_deny()
    end
  end,

  status = function()
    return function()
      chatbot_usecase.status()
    end
  end,

  resume = function()
    return function()
      chatbot_usecase.resume()
    end
  end,

  continue = function()
    return function()
      chatbot_usecase.continue()
    end
  end,

  open_hub = function()
    return function()
      chatbot_usecase.open_hub()
    end
  end,
}

return make_controller_logged("chatbot", M)
