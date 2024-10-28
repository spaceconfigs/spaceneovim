local M = {}

local logger_use_case = require("application.use_cases.logger")
local lsp_use_case = require("application.use_cases.lsp")
local editor_use_case = require("application.use_cases.editor")
-- local statusline_use_case = require("application.use_cases.statusline")
-- local fold_use_case = require("application.use_cases.fold")

M.onFiletypeInit = function(filetype)
  local message = {
    module = "hooks/buffer",
    func = "onFiletypeInit",
  }
  logger_use_case.debug(message)

  editor_use_case.apply_rules(filetype)
end

M.onBufferInit = function()
  local message = {
    module = "events/buffer",
    func = "onBufferInit",
  }
  logger_use_case.debug(message)

  lsp_use_case.setup()
  -- statusline_use_case.toggle()
  -- fold_use_case.setup()
end

return M
