local make_controller_logged = require("application.helpers.make_controller_logged")
local chatbot_use_case = require("application.use_cases.chatbot")

---@type ChatbotContract
local M = {
  toggle = function()
    return function()
      chatbot_use_case.toggle()
    end
  end,

  focus = function()
    return function()
      chatbot_use_case.focus()
    end
  end,

  send = function()
    return function()
      chatbot_use_case.send()
    end
  end,

  add_buffer = function()
    return function()
      chatbot_use_case.add_buffer()
    end
  end,

  add_file = function()
    return function()
      chatbot_use_case.add_file()
    end
  end,

  add = function()
    return function()
      chatbot_use_case.add()
    end
  end,

  select_model = function()
    return function()
      chatbot_use_case.select_model()
    end
  end,

  diff_accept = function()
    return function()
      chatbot_use_case.diff_accept()
    end
  end,

  diff_deny = function()
    return function()
      chatbot_use_case.diff_deny()
    end
  end,

  status = function()
    return function()
      chatbot_use_case.status()
    end
  end,

  resume = function()
    return function()
      chatbot_use_case.resume()
    end
  end,

  continue = function()
    return function()
      chatbot_use_case.continue()
    end
  end,
}

return make_controller_logged("chatbot", M)
