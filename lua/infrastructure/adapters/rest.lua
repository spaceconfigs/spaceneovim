local M = {}

local make_logged = require("application.helpers.make_logged")
local plugins = require("infrastructure.plugins.rest")
local hurl = plugins.hurl
local kulala = plugins.kulala

M.open = function(opts)
  -- kulala.toggle_view()
  vim.cmd("HurlShowLastResponse")
end

M.send = function(opts)
  -- kulala.run_all()
  vim.cmd("HurlRunner")
  -- vim.cmd("Rest open")
end

M.replay = function(opts)
  -- kulala.replay()
  vim.cmd("HurlRerun")
  -- vim.cmd("Rest open")
end

return make_logged("adapters/rest", M)
