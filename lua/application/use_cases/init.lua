--- Composition root: wires concrete use cases into the application UseCaseRegistry
--- as LAZY resolvers (nothing is required until first called). Must run at bootstrap
--- before controllers resolve a use case. The setup requires below run use cases'
--- one-time side effects and are unrelated to the registry population above them.

local registry = require("application.ports.use_case_registry")

local modules = {
  bookmarker = "application.use_cases.bookmarker",
  buffer = "application.use_cases.buffer",
  changer = "application.use_cases.changer",
  chatbot = "application.use_cases.chatbot",
  commander = "application.use_cases.commander",
  commenter = "application.use_cases.commenter",
  completer = "application.use_cases.completer",
  database = "application.use_cases.database",
  debugger = "application.use_cases.debugger",
  diagnostic = "application.use_cases.diagnostic",
  documentation = "application.use_cases.documentation",
  editor = "application.use_cases.editor",
  file = "application.use_cases.file",
  fold = "application.use_cases.fold",
  formatter = "application.use_cases.formatter",
  hover = "application.use_cases.hover",
  jumper = "application.use_cases.jumper",
  layout = "application.use_cases.layout",
  linenumber = "application.use_cases.linenumber",
  lsp = "application.use_cases.lsp",
  notebook = "application.use_cases.notebook",
  noter = "application.use_cases.noter",
  notification = "application.use_cases.notification",
  outline = "application.use_cases.outline",
  packager = "application.use_cases.packager",
  pomodoro = "application.use_cases.pomodoro",
  quit = "application.use_cases.quit",
  rest = "application.use_cases.rest",
  screenshot = "application.use_cases.screenshot",
  searcher = "application.use_cases.searcher",
  selector = "application.use_cases.selector",
  statusline = "application.use_cases.statusline",
  terminal = "application.use_cases.terminal",
  tester = "application.use_cases.tester",
  theme = "application.use_cases.theme",
  todo = "application.use_cases.todo",
  toggler = "application.use_cases.toggler",
  tree = "application.use_cases.tree",
  versior = "application.use_cases.versior",
  window = "application.use_cases.window",
  workspace = "application.use_cases.workspace",
  zen = "application.use_cases.zen",
  zoom = "application.use_cases.zoom",
}

for name, module in pairs(modules) do
  registry[name] = function()
    return require(module)
  end
end

require("application.use_cases.packager")
require("application.use_cases.logger")
require("application.use_cases.notification")
require("application.use_cases.keymapper")

-- require("application.use_cases.bookmarker")
-- require("application.use_cases.buffer")
-- require("application.use_cases.commenter")
-- require("application.use_cases.completer")
-- require("application.use_cases.debugger")
-- require("application.use_cases.file")
-- require("application.use_cases.formatter")
-- require("application.use_cases.jumper")
-- require("application.use_cases.logger")
-- require("application.use_cases.lsp")
-- require("application.use_cases.mapper")
-- require("application.use_cases.noter")
-- require("application.use_cases.notification")
-- require("application.use_cases.session")
-- require("application.use_cases.terminal")
-- require("application.use_cases.todo")
-- require("application.use_cases.tree")
-- require("application.use_cases.versior")
-- require("application.use_cases.window")
-- require("application.use_cases.workspace")
-- require("application.use_cases.logger")
