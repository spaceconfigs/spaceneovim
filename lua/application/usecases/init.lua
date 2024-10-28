--- Composition root: wires concrete use cases into the application UseCaseRegistry
--- as LAZY resolvers (nothing is required until first called). Must run at bootstrap
--- before controllers resolve a use case. The setup requires below run use cases'
--- one-time side effects and are unrelated to the registry population above them.

local registry = require("application.ports.usecase_registry")

local modules = {
  autotag = "application.usecases.autotag",
  bookmarker = "application.usecases.bookmarker",
  buffer = "application.usecases.buffer",
  changer = "application.usecases.changer",
  chatbot = "application.usecases.chatbot",
  commander = "application.usecases.commander",
  commenter = "application.usecases.commenter",
  completer = "application.usecases.completer",
  database = "application.usecases.database",
  debugger = "application.usecases.debugger",
  diagnostic = "application.usecases.diagnostic",
  documentation = "application.usecases.documentation",
  editor = "application.usecases.editor",
  file = "application.usecases.file",
  fold = "application.usecases.fold",
  formatter = "application.usecases.formatter",
  hover = "application.usecases.hover",
  jumper = "application.usecases.jumper",
  layout = "application.usecases.layout",
  linenumber = "application.usecases.linenumber",
  lsp = "application.usecases.lsp",
  notebook = "application.usecases.notebook",
  noter = "application.usecases.noter",
  notification = "application.usecases.notification",
  outline = "application.usecases.outline",
  packager = "application.usecases.packager",
  pomodoro = "application.usecases.pomodoro",
  quit = "application.usecases.quit",
  rest = "application.usecases.rest",
  screenshot = "application.usecases.screenshot",
  searcher = "application.usecases.searcher",
  selector = "application.usecases.selector",
  statusline = "application.usecases.statusline",
  terminal = "application.usecases.terminal",
  tester = "application.usecases.tester",
  theme = "application.usecases.theme",
  todo = "application.usecases.todo",
  toggler = "application.usecases.toggler",
  tree = "application.usecases.tree",
  versior = "application.usecases.versior",
  window = "application.usecases.window",
  workspace = "application.usecases.workspace",
  zen = "application.usecases.zen",
  zoom = "application.usecases.zoom",
}

for name, module in pairs(modules) do
  registry[name] = function()
    return require(module)
  end
end

require("application.usecases.packager")
require("application.usecases.logger")
require("application.usecases.notification")
require("application.usecases.keymapper")

-- require("application.usecases.bookmarker")
-- require("application.usecases.buffer")
-- require("application.usecases.commenter")
-- require("application.usecases.completer")
-- require("application.usecases.debugger")
-- require("application.usecases.file")
-- require("application.usecases.formatter")
-- require("application.usecases.jumper")
-- require("application.usecases.logger")
-- require("application.usecases.lsp")
-- require("application.usecases.mapper")
-- require("application.usecases.noter")
-- require("application.usecases.notification")
-- require("application.usecases.session")
-- require("application.usecases.terminal")
-- require("application.usecases.todo")
-- require("application.usecases.tree")
-- require("application.usecases.versior")
-- require("application.usecases.window")
-- require("application.usecases.workspace")
-- require("application.usecases.logger")
