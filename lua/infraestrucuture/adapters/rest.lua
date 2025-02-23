local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugins = require("infraestrucuture.plugins.rest")
local hurl = plugins.hurl

M.send = function(opts)
  local message = {
    module = "adapters/request",
    func = "search",
    opts = opts,
  }
  logger_use_manage.debug(message)

  vim.cmd("HurlRunner")
end

return M
