local M = {}

local logger_use_manage = require("application.use_cases.logger")
local plugin = require("infraestrucuture.plugins.documentation")

  vim.cmd("DevdocsOpenFloat")
M.open = function()
  local message = {
    module = "adapters/documentation",
    func = "open",
  }
  logger_use_manage.debug(message)

  -- vim.cmd("DevdocsOpen")
  vim.cmd("DevdocsOpenFloat")
end

return M

-- local M = {}
--
-- local logger_use_manage = require("application.use_cases.logger")
-- local plugin = require("infraestrucuture.plugins.documentation")
-- local snacks = plugin.snacks
-- local devdocs = plugin.devdocs
--
-- M.open = function()
--   local message = {
--     module = "adapters/documentation",
--     func = "open",
--   }
--   logger_use_manage.debug(message)
--
--   local installedDocs = devdocs.GetInstalledDocs()
--   vim.ui.select(installedDocs, {}, function(selected)
--     if not selected then
--       return
--     end
--     local docDir = devdocs.GetDocDir(selected)
--
--     -- snacks.picker.grep({
--     --   layout = { preset = "nitaicharan" },
--     --   cmd = docDir,
--     -- })
--
--     snacks.picker.files({
--       layout = { preset = "nitaicharan" },
--       cwd = docDir
--     })
--   end)
-- end
--
-- return M
