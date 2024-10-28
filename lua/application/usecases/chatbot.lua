local M = {}
local make_logged = require("application.helpers.make_logged")

M.setup = function()
  return require("application.ports.adapter_registry").chatbot()
end

M.toggle = function()
  local adapter = M.setup()
  adapter.toggle()
end

M.focus = function()
  local adapter = M.setup()
  adapter.focus()
end

M.send = function()
  local editor = require("application.ports.adapter_registry").editor()
  local mode = editor.current_mode()
  local is_visual = mode == "v" or mode == "V" or mode == "\22"

  local content = nil
  if is_visual then
    editor.escape_visual()
    content = editor.visual_mention() .. "\n"
  end

  local composer = require("application.ports.adapter_registry").composer()

  composer.open({
    content = content,
    on_submit = function(text)
      M.setup().send(text)
    end,
  })
end

M.add_buffer = function()
  local editor = require("application.ports.adapter_registry").editor()
  local content = editor.buffer_mention() .. "\n"

  local composer = require("application.ports.adapter_registry").composer()

  composer.open({
    content = content,
    on_submit = function(text)
      M.setup().send(text)
    end,
  })
end

M.add_word = function()
  local editor = require("application.ports.adapter_registry").editor()
  local content = string.format("`%s`\n\n", editor.cword())

  local composer = require("application.ports.adapter_registry").composer()

  composer.open({
    content = content,
    on_submit = function(text)
      M.setup().send(text)
    end,
  })
end

M.add_selection = function()
  local editor = require("application.ports.adapter_registry").editor()
  local ft = editor.filetype()
  editor.escape_visual()
  local selection = editor.visual_selection()
  local content = string.format("```%s\n%s\n```\n", ft, selection)

  local composer = require("application.ports.adapter_registry").composer()

  composer.open({
    content = content,
    on_submit = function(text)
      M.setup().send(text)
    end,
  })
end

M.add_file = function()
  local adapter = M.setup()
  adapter.add_file()
end

M.add = function()
  local adapter = M.setup()
  adapter.add()
end

M.select_model = function()
  local adapter = M.setup()
  adapter.select_model()
end

M.diff_accept = function()
  local adapter = M.setup()
  adapter.diff_accept()
end

M.diff_deny = function()
  local adapter = M.setup()
  adapter.diff_deny()
end

M.status = function()
  local adapter = M.setup()
  adapter.status()
end

M.resume = function()
  local adapter = M.setup()
  adapter.resume()
end

M.continue = function()
  local adapter = M.setup()
  adapter.continue()
end

M.open_hub = function()
  M.setup().open_hub()
end

---@param buffer integer
M.scroll_to_bottom = function(buffer)
  local adapter = M.setup()
  adapter.scroll_to_bottom(buffer)
end

return make_logged("usecases/chatbot", M)
