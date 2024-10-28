local M = {}

local logger_usecase = require("application.use_cases.logger")
local lsp_usecase = require("application.use_cases.lsp")
local editor_usecase = require("application.use_cases.editor")
-- local statusline_usecase = require("application.use_cases.statusline")
-- local fold_usecase = require("application.use_cases.fold")

M.on_filetype_init = function(filetype)
  local message = {
    module = "hooks/buffer",
    func = "on_filetype_init",
  }
  logger_usecase.debug(message)

  editor_usecase.apply_rules(filetype)
end

M.on_buffer_init = function()
  local message = {
    module = "events/buffer",
    func = "on_buffer_init",
  }
  logger_usecase.debug(message)

  lsp_usecase.setup()
  -- statusline_usecase.toggle()
  -- fold_usecase.setup()
end

return M
