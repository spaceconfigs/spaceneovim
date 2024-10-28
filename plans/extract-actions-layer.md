# Plan: Extract `application/controllers/` layer

## Context

Maps in `domain/maps/` directly require `application/use_cases/`. Use cases serve two roles:
1. **Currying**: `function(opts) return function() ... end end` — creates closures for keybindings
2. **Business logic**: logging, lazy-loading adapters, computing values, delegating to adapters

This plan separates these concerns into a new `application/controllers/` module.

## New module: `lua/application/controllers/`

Lives in application layer (parallel to `use_cases/`). Controllers own the currying pattern — they accept params at map-definition time and return a closure for keypress execution. This follows Clean Architecture where controllers receive input and delegate to use cases.

**New dependency chain:**
```
domain/maps/ → application/controllers/ → application/use_cases/ → infrastructure/adapters/
```

## Transformation

**Controller file** (new — owns currying + logging):
```lua
local logger = require("application.use_cases.logger")
local use_case = require("application.use_cases.chatbot")

M.session = function(opts)
    return function()
        logger.debug({ module = "controllers/chatbot", func = "session", opts = opts })
        use_case.session(opts)
    end
end
```

**Use case** (simplified — direct execution, no wrapping):
```lua
M.session = function(opts)
    local adapter = M.setup()
    adapter.session(opts)
end
```

**Map** (require path changes, call syntax unchanged):
```lua
local controller = require("application.controllers.chatbot")
{ key = "ds", description = "Start", method = controller.session({ action = "start" }) }
```

## Three current patterns to handle

1. **Curried with params** (`go_to(N)`, `session(opts)`) → controller takes params, returns closure
2. **Curried no params** (`close()`, `split()`, `all()`) → controller returns closure, no params
3. **Direct reference** (`go_left`, `toggle`, `dedicate`) → controller wraps into curried pattern (`controller.go_left()` returns closure), normalizing with the existing `normalize-map-methods` spec

## Special cases

- **Use cases with inline business logic** (`window.lua` has `vim.api` calls for shrink/expand/balance, `searcher.lua` computes paths): logic stays in use case, controller just curries and delegates
- **Logging moves to controllers** — controllers are the boundary between "key triggered" and "logic executes"
- **Use cases called only from hooks** (not maps) — no controller needed, unchanged
- **`M.setup()` stays in use cases** — adapter lazy-loading is a use case concern

## Files affected

**~19 new controller files** in `application/controllers/` (one per use case referenced by maps):
chatbot, editor, quit, toggler, window, terminal, searcher, file, jumper, lsp, diagnostic, workspace, buffer, commenter, commander, hover, completer, zen, notification

**~20 map files** updated: change `require("application.use_cases.X")` → `require("application.controllers.X")`

**~19 use case files** simplified: remove `return function()` wrapping, become direct functions

**Unchanged:** adapters, plugins, hooks, logger, keymapper, theme

## Coordinates with

`specs/normalize-map-methods.md` — Pattern 3 (direct references like `buffer_use_case.reopen`) should be normalized to curried calls (`controller.reopen()`) as part of this work.

## Verification

1. Every `method` field in `domain/maps/*.lua` calls a controller function (not a use case)
2. Every controller function returns a function
3. Every use case function executes directly (no `return function()` wrapping)
4. Neovim starts without errors
5. All keybindings work as before
