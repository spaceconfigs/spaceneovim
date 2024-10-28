--- Composition root: wires concrete application controllers into the domain
--- ControllerRegistry as LAZY resolvers (nothing is required until first called).
--- Must run at bootstrap before maps resolve a controller.

local registry = require("domain.contracts.registry")

--- Controller name → module that provides its concrete controller.
local modules = {
  bookmarker = "application.controllers.bookmarker",
  buffer = "application.controllers.buffer",
  changer = "application.controllers.changer",
  chatbot = "application.controllers.chatbot",
  commander = "application.controllers.commander",
  commenter = "application.controllers.commenter",
  completer = "application.controllers.completer",
  database = "application.controllers.database",
  debugger = "application.controllers.debugger",
  diagnostic = "application.controllers.diagnostic",
  documentation = "application.controllers.documentation",
  editor = "application.controllers.editor",
  file = "application.controllers.file",
  fold = "application.controllers.fold",
  formatter = "application.controllers.formatter",
  hover = "application.controllers.hover",
  jumper = "application.controllers.jumper",
  layout = "application.controllers.layout",
  linenumber = "application.controllers.linenumber",
  lsp = "application.controllers.lsp",
  notebook = "application.controllers.notebook",
  noter = "application.controllers.noter",
  notification = "application.controllers.notification",
  outline = "application.controllers.outline",
  packager = "application.controllers.packager",
  pomodoro = "application.controllers.pomodoro",
  quit = "application.controllers.quit",
  rest = "application.controllers.rest",
  screenshot = "application.controllers.screenshot",
  searcher = "application.controllers.searcher",
  selector = "application.controllers.selector",
  statusline = "application.controllers.statusline",
  terminal = "application.controllers.terminal",
  tester = "application.controllers.tester",
  theme = "application.controllers.theme",
  todo = "application.controllers.todo",
  toggler = "application.controllers.toggler",
  tree = "application.controllers.tree",
  versior = "application.controllers.versior",
  window = "application.controllers.window",
  workspace = "application.controllers.workspace",
  zen = "application.controllers.zen",
  zoom = "application.controllers.zoom",
}

for name, module in pairs(modules) do
  registry[name] = function()
    return require(module)
  end
end
