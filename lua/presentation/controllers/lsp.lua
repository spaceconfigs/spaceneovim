local make_controller_logged = require("application.helpers.make_controller_logged")
local lsp_usecase = require("application.ports.usecase_registry").lsp()

---@type LspContract
local M = {
  navigate = function(opts)
    return function()
      lsp_usecase.navigate(opts.type, opts.options)
    end
  end,

  show_signature = function()
    return function()
      lsp_usecase.show_signature()
    end
  end,

  show_documentation = function()
    return function()
      lsp_usecase.show_documentation()
    end
  end,

  show_code_action = function()
    return function()
      lsp_usecase.show_code_action()
    end
  end,

  format = function()
    return function()
      lsp_usecase.format()
    end
  end,

  diagnostics = function()
    return function()
      lsp_usecase.diagnostics()
    end
  end,

  info = function()
    return function()
      lsp_usecase.info()
    end
  end,

  restart = function()
    return function()
      lsp_usecase.restart()
    end
  end,

  rename = function()
    return function()
      lsp_usecase.rename()
    end
  end,

  get_symbol = function()
    return function()
      lsp_usecase.get_symbol()
    end
  end,
}

return make_controller_logged("lsp", M)
