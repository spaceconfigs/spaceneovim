local M = {}

M.setup = function()
  return require("infrastructure.adapters.completer")
end

M.complete = function()
  local adapter = M.setup()

  adapter.complete()
end

return M
