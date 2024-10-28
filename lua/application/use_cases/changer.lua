local M = {}

M.setup = function()
  return require("infrastructure.adapters.changer")
end

M.list = function()
  local adapter = M.setup()

  adapter.list()
end

return M
