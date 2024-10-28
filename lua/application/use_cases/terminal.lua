local M = {}
local make_logged = require("application.helpers.make_logged")

local file_util = require("infrastructure.utils.file")

vim.g.terminal_opened = false

M.setup = function()
  return require("infrastructure.adapters.terminal")
end

---@param options? { type?: "internal"|"external", location?: "file"|"project", path?: string }
M.toggle = function(options)
  local adapter = M.setup()

  options = options or {}
  options.type = options.type or 'internal'
  options.location = options.location or 'file'
  options.path = file_util.project("file")

  if options.location == 'project' then
    options.path = file_util.project("project")
  end

  adapter.toggle(options)
end

return make_logged("use_cases/terminal", M)
