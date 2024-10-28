local M = {}

local logger_use_case = require("application.use_cases.logger")
local plugins = require("infrastructure.plugins.rest")
local hurl = plugins.hurl
local kulala = plugins.kulala

M.open = function(opts)
  local message = {
    module = "adapters/request",
    func = "search",
    opts = opts,
  }
  logger_use_case.debug(message)

  -- kulala.toggle_view()
  vim.cmd("HurlShowLastResponse")
end

M.send = function(opts)
  local message = {
    module = "adapters/request",
    func = "search",
    opts = opts,
  }
  logger_use_case.debug(message)

  -- kulala.run_all()
  vim.cmd("HurlRunner")
  -- vim.cmd("Rest open")
end

M.replay = function(opts)
  local message = {
    module = "adapters/request",
    func = "search",
    opts = opts,
  }
  logger_use_case.debug(message)

  -- kulala.replay()
  vim.cmd("HurlRerun")
  -- vim.cmd("Rest open")
end

return M
