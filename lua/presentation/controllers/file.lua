local make_controller_logged = require("application.helpers.make_controller_logged")
local file_usecase = require("application.ports.usecase_registry").file()

---@type FileContract
local M = {
  oldfiles = function(opts)
    return function()
      file_usecase.oldfiles(opts)
    end
  end,

  list = function(opts)
    return function()
      file_usecase.list(opts)
    end
  end,

  search = function()
    return function()
      file_usecase.search()
    end
  end,

  search_hover = function()
    return function()
      file_usecase.search_hover()
    end
  end,

  rename = function()
    return function()
      file_usecase.rename()
    end
  end,

  edit_config = function()
    return function()
      file_usecase.edit_config()
    end
  end,

  source_config = function()
    return function()
      file_usecase.source_config()
    end
  end,

  delete_current = function()
    return function()
      file_usecase.delete_current()
    end
  end,

  save = function()
    return function()
      file_usecase.save()
    end
  end,

  save_all = function()
    return function()
      file_usecase.save_all()
    end
  end,

  copy = function(opts)
    return function()
      file_usecase.copy(opts)
    end
  end,
}

return make_controller_logged("file", M)
