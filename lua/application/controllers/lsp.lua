local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")
local lsp_use_case = require("application.use_cases.lsp")

M.navigate = function(opts)
  return function()
    lsp_use_case.navigate(opts.type, opts.options)
  end
end

M.show_signature = function()
  return function()
    lsp_use_case.show_signature()
  end
end

M.show_documentation = function()
  return function()
    lsp_use_case.show_documentation()
  end
end

M.show_code_action = function()
  return function()
    lsp_use_case.show_code_action()
  end
end

M.format = function()
  return function()
    lsp_use_case.format()
  end
end

M.diagnostics = function()
  return function()
    lsp_use_case.diagnostics()
  end
end

M.info = function()
  return function()
    lsp_use_case.info()
  end
end

M.restart = function()
  return function()
    lsp_use_case.restart()
  end
end

M.rename = function()
  return function()
    lsp_use_case.rename()
  end
end

M.get_symbol = function()
  return function()
    lsp_use_case.get_symbol()
  end
end

return make_controller_logged("lsp", M)
