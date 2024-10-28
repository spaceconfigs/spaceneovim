local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local chatbot_use_case = require("application.use_cases.chatbot")

M.toggle = function(opts)
  return function()
    chatbot_use_case.toggle(opts)
  end
end

M.edit = function(opts)
  return function()
    chatbot_use_case.edit(opts)
  end
end

M.zenmode = function(opts)
  return function()
    chatbot_use_case.zenmode(opts)
  end
end

M.session = function(opts)
  return function()
    chatbot_use_case.session(opts)
  end
end

M.send_prompt = function(opts)
  return function()
    chatbot_use_case.send_prompt(opts)
  end
end

M.add_file = function(opts)
  return function()
    chatbot_use_case.add_file(opts)
  end
end

M.select_model = function(opts)
  return function()
    chatbot_use_case.select_model(opts)
  end
end

M.accept_diff = function(opts)
  return function()
    chatbot_use_case.accept_diff(opts)
  end
end

M.deny_diff = function(opts)
  return function()
    chatbot_use_case.deny_diff(opts)
  end
end

return make_controller_logged("chatbot", M)
