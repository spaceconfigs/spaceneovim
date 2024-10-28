local make_controller_logged = require("application.helpers.make_controller_logged")
local lsp_use_case = require("application.ports.use_case_registry").lsp()

---@type LspContract
local M = {
  navigate = function(opts)
    return function()
      lsp_use_case.navigate(opts.type, opts.options)
    end
  end,

  show_signature = function()
    return function()
      lsp_use_case.show_signature()
    end
  end,

  show_documentation = function()
    return function()
      lsp_use_case.show_documentation()
    end
  end,

  show_code_action = function()
    return function()
      lsp_use_case.show_code_action()
    end
  end,

  format = function()
    return function()
      lsp_use_case.format()
    end
  end,

  diagnostics = function()
    return function()
      lsp_use_case.diagnostics()
    end
  end,

  info = function()
    return function()
      lsp_use_case.info()
    end
  end,

  restart = function()
    return function()
      lsp_use_case.restart()
    end
  end,

  rename = function()
    return function()
      lsp_use_case.rename()
    end
  end,

  get_symbol = function()
    return function()
      lsp_use_case.get_symbol()
    end
  end,
}

return make_controller_logged("lsp", M)
