local M = {}

local logger_usecase = require("application.usecases.logger")
local terminal_usecase = require("application.usecases.terminal")

M.on_terminal_open = function(_)
end

M.on_terminal_output = function(_)
end

M.on_terminal_destroy = function(args)
  logger_usecase.debug({
    module = "hooks/terminal",
    func = "on_terminal_destroy",
  })

  terminal_usecase.on_exit({ buffer = args.buf, status = args.status })
end

return M
