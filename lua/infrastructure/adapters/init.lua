--- Composition root: wires concrete infrastructure adapters into the application
--- port registry as LAZY resolvers (nothing is loaded until first called, so plugin
--- lazy-loading is preserved). Must run at bootstrap before use cases resolve a port.
--- (the resolver binds require's result to a local to truncate its 1-2 return values to the single port.)

local registry = require("application.ports.adapter_registry")

--- Port name → module that provides its concrete adapter.
local modules = {
	autotag = "infrastructure.adapters.autotag",
	bookmarker = "infrastructure.adapters.bookmarker",
	buffer = "infrastructure.adapters.buffer",
	changer = "infrastructure.adapters.changer",
	chatbot = "infrastructure.adapters.chatbot",
	commander = "infrastructure.adapters.commander",
	commenter = "infrastructure.adapters.commenter",
	completer = "infrastructure.adapters.completer",
	composer = "infrastructure.adapters.composer",
	database = "infrastructure.adapters.database",
	debugger = "infrastructure.adapters.debugger",
	diagnostic = "infrastructure.adapters.diagnostic",
	documentation = "infrastructure.adapters.documentation",
	editor = "infrastructure.adapters.editor",
	file = "infrastructure.adapters.file",
	fold = "infrastructure.adapters.fold",
	formatter = "infrastructure.adapters.formatter",
	hover = "infrastructure.adapters.hover",
	jumper = "infrastructure.adapters.jumper",
	keymapper = "infrastructure.adapters.keymapper",
	layout = "infrastructure.adapters.layout",
	logger = "infrastructure.adapters.logger",
	lsp = "infrastructure.adapters.lsp",
	notebook = "infrastructure.adapters.notebook",
	noter = "infrastructure.adapters.noter",
	notification = "infrastructure.adapters.notification",
	outline = "infrastructure.adapters.outline",
	packager = "infrastructure.adapters.packager",
	pomodoro = "infrastructure.adapters.pomodoro",
	quit = "infrastructure.adapters.quit",
	rest = "infrastructure.adapters.rest",
	screenshot = "infrastructure.adapters.screenshot",
	searcher = "infrastructure.adapters.searcher",
	selector = "infrastructure.adapters.selector",
	statusline = "infrastructure.adapters.statusline",
	terminal = "infrastructure.adapters.terminal",
	tester = "infrastructure.adapters.tester",
	theme = "infrastructure.adapters.theme",
	todo = "infrastructure.adapters.todo",
	toggler = "infrastructure.adapters.toggler",
	tree = "infrastructure.adapters.tree",
	versior = "infrastructure.adapters.versior",
	window = "infrastructure.adapters.window",
	workspace = "infrastructure.adapters.workspace",
	zen = "infrastructure.adapters.zen",
	zoom = "infrastructure.adapters.zoom",
	file_util = "infrastructure.utils.file",
}

for name, module in pairs(modules) do
	registry[name] = function()
		local adapter = require(module)

		return adapter
	end
end
