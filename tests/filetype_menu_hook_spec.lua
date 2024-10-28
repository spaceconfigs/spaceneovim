-- Headless spec: the filetype hook forwards its filetype to the keymapper usecase.
--   nvim --headless -u NONE -c "luafile tests/filetype_menu_hook_spec.lua" -c "qa!"
package.path = "./lua/?.lua;./lua/?/init.lua;" .. package.path

package.loaded["application.usecases.logger"] =
  { debug = function() end, info = function() end, warn = function() end, error = function() end, log = function() end }

-- Stub every collaborator the hook pulls in, recording the keymapper call.
local seen = {}
package.loaded["application.usecases.lsp"] = { setup = function() end }
package.loaded["application.usecases.editor"] = {
  apply_rules = function() end,
  start_highlighting = function() end,
}
package.loaded["application.usecases.autotag"] = { setup = function() end }
package.loaded["application.usecases.keymapper"] = {
  register_filetype = function(filetype)
    seen[#seen + 1] = filetype
  end,
}

local hook = require("presentation.hooks.buffer")

local failures = 0
local function check(label, cond)
  print((cond and "ok   - " or "FAIL - ") .. label)
  if not cond then
    failures = failures + 1
  end
end

hook.on_filetype_init("spec_alpha")
check("hook forwards the filetype to register_filetype", seen[1] == "spec_alpha")

hook.on_filetype_init("lua")
check("hook forwards every filetype, filtering is the usecase's job", seen[2] == "lua")
check("hook called register_filetype exactly once per event", #seen == 2)

if failures > 0 then
  vim.cmd("cq")
end
