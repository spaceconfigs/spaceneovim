--- Composition root: wires concrete presentation hooks into the domain
--- HookRegistry as LAZY resolvers (nothing is required until first called).
--- Must run at bootstrap before infrastructure events resolve a hook.

local registry = require("domain.contracts.hook_registry")

--- Hook name → module that provides its concrete hook.
local modules = {
  buffer = "presentation.hooks.buffer",
  debugger = "presentation.hooks.debugger",
  lifecycle = "presentation.hooks.lifecycle",
  lsp = "presentation.hooks.lsp",
  terminal = "presentation.hooks.terminal",
}

for name, module in pairs(modules) do
  registry[name] = function()
    return require(module)
  end
end
