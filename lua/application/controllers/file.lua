local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local file_use_case = require("application.use_cases.file")

M.oldfiles = function(opts)
  return function()
    file_use_case.oldfiles(opts)
  end
end

M.list = function(opts)
  return function()
    file_use_case.list(opts)
  end
end

M.search = function()
  return function()
    file_use_case.search()
  end
end

M.search_hover = function()
  return function()
    file_use_case.search_hover()
  end
end

M.rename = function()
  return function()
    file_use_case.rename()
  end
end

M.edit_config = function()
  return function()
    file_use_case.edit_config()
  end
end

M.source_config = function()
  return function()
    file_use_case.source_config()
  end
end

M.delete_current = function()
  return function()
    file_use_case.delete_current()
  end
end

M.save = function()
  return function()
    file_use_case.save()
  end
end

M.save_all = function()
  return function()
    file_use_case.save_all()
  end
end

M.copy = function(opts)
  return function()
    file_use_case.copy(opts)
  end
end

return make_controller_logged("file", M)
