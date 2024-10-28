local M = {}

local logger_usecase = require("application.usecases.logger")
local lsp_usecase = require("application.usecases.lsp")
local editor_usecase = require("application.usecases.editor")
local autotag_usecase = require("application.usecases.autotag")
local treesitter_usecase = require("application.usecases.treesitter")
-- local statusline_usecase = require("application.usecases.statusline")
-- local fold_usecase = require("application.usecases.fold")

M.on_filetype_init = function(filetype)
  local message = {
    module = "hooks/buffer",
    func = "on_filetype_init",
  }
  logger_usecase.debug(message)

  editor_usecase.apply_rules(filetype)
  editor_usecase.start_highlighting()
  autotag_usecase.setup(filetype)
end

M.on_buffer_init = function()
  local message = {
    module = "events/buffer",
    func = "on_buffer_init",
  }
  logger_usecase.debug(message)

  treesitter_usecase.setup()
  lsp_usecase.setup()
  -- statusline_usecase.toggle()
  -- fold_usecase.setup()
end

return M
