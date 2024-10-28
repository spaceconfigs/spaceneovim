--- Composition root: wires plugin wrappers into the PluginRegistry as LAZY
--- resolvers (the wrapper is only required on first call, preserving plugin
--- lazy-loading). Keyed by plugin MODULE name. Must run at bootstrap.

local registry = require("infrastructure.plugins.registry")

local modules = {
  bookmarker = "infrastructure.plugins.bookmarker",
  buffer = "infrastructure.plugins.buffer",
  changer = "infrastructure.plugins.changer",
  chatbot = "infrastructure.plugins.chatbot",
  commenter = "infrastructure.plugins.commenter",
  completer = "infrastructure.plugins.completer",
  composer = "infrastructure.plugins.composer",
  database = "infrastructure.plugins.database",
  debugger = "infrastructure.plugins.debugger",
  diagnostic = "infrastructure.plugins.diagnostic",
  documentation = "infrastructure.plugins.documentation",
  file = "infrastructure.plugins.file",
  fold = "infrastructure.plugins.fold",
  formatter = "infrastructure.plugins.formatter",
  hover = "infrastructure.plugins.hover",
  jump = "infrastructure.plugins.jump",
  keymapper = "infrastructure.plugins.keymapper",
  layout = "infrastructure.plugins.layout",
  lazy = "infrastructure.plugins.lazy",
  logger = "infrastructure.plugins.logger",
  lsp = "infrastructure.plugins.lsp",
  notebook = "infrastructure.plugins.notebook",
  noter = "infrastructure.plugins.noter",
  notification = "infrastructure.plugins.notification",
  outline = "infrastructure.plugins.outline",
  pomodoro = "infrastructure.plugins.pomodoro",
  rest = "infrastructure.plugins.rest",
  screenshot = "infrastructure.plugins.screenshot",
  searcher = "infrastructure.plugins.searcher",
  selector = "infrastructure.plugins.selector",
  statusline = "infrastructure.plugins.statusline",
  terminal = "infrastructure.plugins.terminal",
  tester = "infrastructure.plugins.tester",
  theme = "infrastructure.plugins.theme",
  todo = "infrastructure.plugins.todo",
  tree = "infrastructure.plugins.tree",
  versior = "infrastructure.plugins.versior",
  window = "infrastructure.plugins.window",
  workspaces = "infrastructure.plugins.workspaces",
  zen = "infrastructure.plugins.zen",
  zoom = "infrastructure.plugins.zoom",
}

for name, module in pairs(modules) do
  registry[name] = function()
    return require(module)
  end
end
