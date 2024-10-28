local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local chatbot_use_case = require("application.use_cases.chatbot")

M.toggle = function()
  return function()
    chatbot_use_case.toggle()
  end
end

M.focus = function()
  return function()
    chatbot_use_case.focus()
  end
end

M.send = function()
  return function()
    chatbot_use_case.send()
  end
end

M.add_buffer = function()
  return function()
    chatbot_use_case.add_buffer()
  end
end

M.add_file = function()
  return function()
    chatbot_use_case.add_file()
  end
end

M.add = function()
  return function()
    chatbot_use_case.add()
  end
end

M.select_model = function()
  return function()
    chatbot_use_case.select_model()
  end
end

M.diff_accept = function()
  return function()
    chatbot_use_case.diff_accept()
  end
end

M.diff_deny = function()
  return function()
    chatbot_use_case.diff_deny()
  end
end

M.status = function()
  return function()
    chatbot_use_case.status()
  end
end

M.resume = function()
  return function()
    chatbot_use_case.resume()
  end
end

M.continue = function()
  return function()
    chatbot_use_case.continue()
  end
end

return make_controller_logged("chatbot", M)
