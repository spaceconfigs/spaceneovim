local M = {}

local logger_use_case = require("application.use_cases.logger")
local lsp_use_case = require("application.use_cases.lsp")
local diagnostic_use_case = require("application.use_cases.diagnostic")
local editor_use_case = require("application.use_cases.editor")
-- local statusline_use_case = require("application.use_cases.statusline")
-- local fold_use_case = require("application.use_cases.fold")

M.onBufferInit = function(filetype)
  local message = {
    module = "hooks/buffer",
    func = "onBufferInit",
  }
  logger_use_case.debug(message)

  editor_use_case.apply_filetype_rules(filetype)
end

M.onInit = function()
  local message = {
    module = "events/buffer",
    func = "onInit",
  }
  logger_use_case.debug(message)

  lsp_use_case.setup()
  -- statusline_use_case.toggle()
  -- fold_use_case.setup()
end

M.onLint = function()
  local message = {
    module = "hooks/buffer",
    func = "onLint",
  }
  logger_use_case.debug(message)

  diagnostic_use_case.lint()
end

return M
