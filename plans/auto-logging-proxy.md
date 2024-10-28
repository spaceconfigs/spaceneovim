# Plan: Auto-logging proxy for all modules

## Context

Logging boilerplate is manually written in every controller and adapter, and absent entirely from use cases. The spec at `specs/auto-logging-proxy.md` defines two proxy helpers — one for use cases and adapters (simple function proxy), one for controllers (curried closure proxy) — that eliminate all manual logging across all three layers.

## Current State

- ✅ `make_logged.lua` — created (but module prefix needs fixing: `"fold"` → `"use_cases/fold"`)
- ✅ Use cases — updated with `make_logged`, but short name passed instead of full path
- ❌ `make_controller_logged.lua` — not created
- ❌ Controllers — not updated
- ❌ Adapters — not updated

## Step 1: Fix `make_logged.lua`

The helper currently receives a full path string (e.g. `"use_cases/fold"`), so no change needed to the helper itself. The fix is in the use case `return` statements.

## Step 2: Fix use case prefixes

All use cases currently pass short names like `make_logged("fold", M)`. Change to full paths:
`make_logged("use_cases/fold", M)` — apply to all 41 use case modules.

## Step 3: Create `make_controller_logged.lua`

**File:** `lua/application/helpers/make_controller_logged.lua`

```lua
local logger_use_case = require("application.use_cases.logger")

return function(module_name, module)
  return setmetatable({}, {
    __index = function(_, func_name)
      local original = module[func_name]
      if type(original) ~= "function" then return original end
      return function(...)
        local args = { ... }
        local closure = original(...)
        if type(closure) ~= "function" then return closure end
        return function()
          logger_use_case.debug({
            module = "controllers/" .. module_name,
            func = func_name,
            args = args,
          })
          return closure()
        end
      end
    end,
  })
end
```

## Step 4: Apply to controllers

For each file in `lua/application/controllers/`:

1. Add `local make_controller_logged = require("application.helpers.make_controller_logged")`
2. Remove all manual `logger_use_case.debug(...)` calls from inside the returned closures
3. Remove `local logger_use_case = require(...)` line
4. Change `return M` → `return make_controller_logged("<name>", M)`

## Step 5: Apply to adapters

For each file in `lua/infrastructure/adapters/`:

1. Add `local make_logged = require("application.helpers.make_logged")`
2. Remove all manual `logger_use_case.debug(...)` calls
3. Remove `local logger_use_case = require(...)` line
4. Change `return M` → `return make_logged("adapters/<name>", M)`

Skip: `logger.lua`, `notification.lua`, `keymapper.lua`, `packager.lua`, `mapper.lua`

## Step 6: Run tests

Run `make test` and verify all contract tests pass.

## Constraints

- Do not change any function body logic
- Log fires inside the closure at keypress time for controllers — `make_controller_logged` handles this
- Keep `logger_use_case.info`/`.error`/`.warn` calls in `file.lua` — only remove `.debug`
- Internal `M.*()` calls bypass the proxy by design
