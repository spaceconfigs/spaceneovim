local M = {}

local logger_usecase = require("application.usecases.logger")
local keymapper_usecase = require("application.usecases.keymapper")
local chatbot_usecase = require("application.usecases.chatbot")
local terminal_usecase = require("application.usecases.terminal")
local editor_usecase = require("application.usecases.editor")

M.on_terminal_open = function(args)
  local name = editor_usecase.current_path(args.buf)
  if not name:match(":claude$") then return end

  local chatbot_controller = require("domain.contracts.registry").chatbot()

  keymapper_usecase.register({
    key = "<leader>$$",
    method = chatbot_controller.toggle(),
    description = "Toggle AI",
    mode = "t",
    buffer = args.buf,
    silent = true,
    noremap = true,
    nowait = false,
  })
end

M.on_terminal_output = function(args)
  chatbot_usecase.scroll_to_bottom(args.buf)
end

M.on_terminal_destroy = function(args)
  logger_usecase.debug({
    module = "hooks/terminal",
    func = "on_terminal_destroy",
  })

  terminal_usecase.on_exit({ buffer = args.buf, status = args.status })
end

return M
