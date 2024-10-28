local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local jumper_use_case = require("application.use_cases.jumper")

M.timer = function(options)
  return function()
    jumper_use_case.timer(options)
  end
end

M.words = function()
  return function()
    jumper_use_case.words()
  end
end

M.lines = function()
  return function()
    jumper_use_case.lines()
  end
end

M.remote = function()
  return function()
    jumper_use_case.remote()
  end
end

return make_controller_logged("jumper", M)
