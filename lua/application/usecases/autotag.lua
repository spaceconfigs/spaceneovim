local M = {}
local make_logged = require("application.helpers.make_logged")

local supported_filetypes = {
  astro = true,
  dot = true,
  glimmer = true,
  handlebars = true,
  html = true,
  javascript = true,
  javascriptreact = true,
  jsx = true,
  liquid = true,
  vento = true,
  markdown = true,
  php = true,
  rescript = true,
  svelte = true,
  tsx = true,
  twig = true,
  typescript = true,
  typescriptreact = true,
  vue = true,
  xml = true,
  lua = true,
}

M.setup = function(filetype)
  if not supported_filetypes[filetype] then
    return
  end

  local adapter = require("application.ports.adapter_registry").autotag()

  adapter.setup()
end

return make_logged("usecases/autotag", M)
