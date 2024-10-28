--- Composition root: wires concrete presentation controllers into the domain
--- ControllerRegistry as LAZY resolvers (nothing is required until first called).
--- Must run at bootstrap before maps resolve a controller.

local registry = require("domain.contracts.controller_registry")

--- Controller name → module that provides its concrete controller.
local modules = {
  bookmarker = "presentation.controllers.bookmarker",
  buffer = "presentation.controllers.buffer",
  changer = "presentation.controllers.changer",
  chatbot = "presentation.controllers.chatbot",
  commander = "presentation.controllers.commander",
  commenter = "presentation.controllers.commenter",
  completer = "presentation.controllers.completer",
  database = "presentation.controllers.database",
  debugger = "presentation.controllers.debugger",
  diagnostic = "presentation.controllers.diagnostic",
  documentation = "presentation.controllers.documentation",
  editor = "presentation.controllers.editor",
  file = "presentation.controllers.file",
  fold = "presentation.controllers.fold",
  formatter = "presentation.controllers.formatter",
  hover = "presentation.controllers.hover",
  jumper = "presentation.controllers.jumper",
  keymapper = "presentation.controllers.keymapper",
  layout = "presentation.controllers.layout",
  linenumber = "presentation.controllers.linenumber",
  lsp = "presentation.controllers.lsp",
  notebook = "presentation.controllers.notebook",
  noter = "presentation.controllers.noter",
  notification = "presentation.controllers.notification",
  outline = "presentation.controllers.outline",
  packager = "presentation.controllers.packager",
  pomodoro = "presentation.controllers.pomodoro",
  quit = "presentation.controllers.quit",
  rest = "presentation.controllers.rest",
  screenshot = "presentation.controllers.screenshot",
  searcher = "presentation.controllers.searcher",
  selector = "presentation.controllers.selector",
  statusline = "presentation.controllers.statusline",
  terminal = "presentation.controllers.terminal",
  tester = "presentation.controllers.tester",
  theme = "presentation.controllers.theme",
  todo = "presentation.controllers.todo",
  toggler = "presentation.controllers.toggler",
  tree = "presentation.controllers.tree",
  versior = "presentation.controllers.versior",
  window = "presentation.controllers.window",
  workspace = "presentation.controllers.workspace",
  zen = "presentation.controllers.zen",
  zoom = "presentation.controllers.zoom",
}

for name, module in pairs(modules) do
  registry[name] = function()
    return require(module)
  end
end
