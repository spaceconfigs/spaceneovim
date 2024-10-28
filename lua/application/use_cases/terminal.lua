local M = {}
local make_logged = require("application.helpers.make_logged")

local file_util = require("application.ports.registry").file_util()
local notification_use_case = require("application.use_cases.notification")

M.setup = function()
  return require("application.ports.registry").terminal()
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

---@param opts { buffer: integer, status: integer }
M.on_exit = function(opts)
  local adapter = M.setup()

  if opts.status == 0 or opts.status == 130 then
    adapter.close_buffer(opts.buffer)
    return
  end

  -- NOTE: original used native vim.notify; this routes through the notification
  -- adapter (snacks) for consistency with the rest of the app.
  notification_use_case.warn(("Terminal exited with code %d"):format(opts.status))
end

return make_logged("use_cases/terminal", M)
