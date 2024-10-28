local M = {}

local logger_use_case = require("application.use_cases.logger")
local keymapper_use_case = require("application.use_cases.keymapper")
local chatbot_use_case = require("application.use_cases.chatbot")
local terminal_use_case = require("application.use_cases.terminal")

M.onOpen = function(args)
  local editor = require("application.ports.registry").editor()
  local name = editor.current_path(args.buf)
  if not name:match(":claude$") then return end

  local chatbot_controller = require("domain.contracts.registry").chatbot()

  keymapper_use_case.register({
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

M.onOutput = function(args)
  chatbot_use_case.scroll_to_bottom(args.buf)
end

M.onDestroy = function(args)
  logger_use_case.debug({
    module = "hooks/terminal",
    func = "onDestroy",
  })

  terminal_use_case.on_exit({ buffer = args.buf, status = args.status })
end

return M
