local make_controller_logged = require("application.helpers.make_controller_logged")
local file_use_case = require("application.use_cases.file")

---@type FileContract
local M = {
  oldfiles = function(opts)
    return function()
      file_use_case.oldfiles(opts)
    end
  end,

  list = function(opts)
    return function()
      file_use_case.list(opts)
    end
  end,

  search = function()
    return function()
      file_use_case.search()
    end
  end,

  search_hover = function()
    return function()
      file_use_case.search_hover()
    end
  end,

  rename = function()
    return function()
      file_use_case.rename()
    end
  end,

  edit_config = function()
    return function()
      file_use_case.edit_config()
    end
  end,

  source_config = function()
    return function()
      file_use_case.source_config()
    end
  end,

  delete_current = function()
    return function()
      file_use_case.delete_current()
    end
  end,

  save = function()
    return function()
      file_use_case.save()
    end
  end,

  save_all = function()
    return function()
      file_use_case.save_all()
    end
  end,

  copy = function(opts)
    return function()
      file_use_case.copy(opts)
    end
  end,
}

return make_controller_logged("file", M)
