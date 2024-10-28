local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local tree_use_case = require("application.use_cases.tree")

M.open = function()
  return function()
    tree_use_case.open()
  end
end

M.close = function()
  return function()
    tree_use_case.close()
  end
end

M.toggle = function(opts)
  return function()
    tree_use_case.toggle(opts)
  end
end

return make_controller_logged("tree", M)
