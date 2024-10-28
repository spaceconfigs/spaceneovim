--- Domain-owned hook registry (composition seam). The presentation layer
--- populates these resolvers at bootstrap; infrastructure events resolve their
--- hook from here (require("domain.contracts.hook_registry").<name>()) instead of
--- importing presentation hooks directly. Mirrors domain/contracts/registry.lua.
--- Hooks expose varied lifecycle methods rather than a uniform contract, so
--- resolvers are typed loosely.
---@class HookRegistry
---@field buffer fun(): table
---@field debugger fun(): table
---@field lifecycle fun(): table
---@field lsp fun(): table
---@field terminal fun(): table
local M = {}

return M
