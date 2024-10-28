# Spec: Auto-logging proxy for all modules

## Problem

Logging boilerplate is duplicated manually across every function in every controller and adapter, and is entirely absent from use cases. Every layer suffers:

**Use cases** — no logging at all:
```lua
M.fold = function(action, opts)
  local adapter = M.setup()
  adapter.fold(action, opts)
end
```

**Controllers** — manual boilerplate repeated in every closure:
```lua
M.go = function(opts)
  return function()
    local message = { module = "controllers/window", func = "go", opts = opts }
    logger_use_case.debug(message)
    window_use_case.go(opts.direction)
  end
end
```

**Adapters** — manual boilerplate repeated in every function:
```lua
M.go = function(direction)
  local message = { module = "adapters/window", func = "go", direction = direction }
  logger_use_case.debug(message)
  vim.cmd("wincmd " .. go_commands[direction])
end
```

This is repetitive, easy to forget on new functions, and clutters business logic. Module name and function name are always derivable from context.

## Target State

Each module contains only business logic. Logging is applied automatically at return time via layer-specific proxy helpers.

### Use cases and adapters — `make_logged`

Same proxy for both layers. Intercepts every function call, logs, then delegates:

```lua
-- use_cases/fold.lua
local M = {}
local make_logged = require("application.helpers.make_logged")

M.fold = function(action, opts)
  opts = opts or {}
  local adapter = M.setup()
  adapter.fold(action, opts)
end

return make_logged("fold", M)
-- logs: { module = "use_cases/fold", func = "fold", args = { action, opts } }
```

```lua
-- adapters/window.lua
local M = {}
local make_logged = require("application.helpers.make_logged")

M.go = function(direction)
  vim.cmd("wincmd " .. go_commands[direction])
end

return make_logged("window", M)
-- logs: { module = "adapters/window", func = "go", args = { direction } }
```

### Controllers — `make_controller_logged`

Controllers use currying: the outer function receives `opts` at map-definition time and returns a closure that fires at keypress time. The log must happen inside the closure (at keypress time), not at definition time. The proxy wraps the returned closure:

```lua
-- controllers/window.lua
local M = {}
local make_controller_logged = require("application.helpers.make_controller_logged")

M.go = function(opts)
  return function()
    window_use_case.go(opts.direction)
  end
end

return make_controller_logged("window", M)
-- at keypress, logs: { module = "controllers/window", func = "go", args = { opts } }
```

## Helper Implementations

### `lua/application/helpers/make_logged.lua` (use cases + adapters)

```lua
local logger_use_case = require("application.use_cases.logger")

return function(module_name, module)
  return setmetatable({}, {
    __index = function(_, func_name)
      local original = module[func_name]
      if type(original) ~= "function" then return original end
      return function(...)
        logger_use_case.debug({
          module = module_name,
          func = func_name,
          args = { ... },
        })
        return original(...)
      end
    end,
  })
end
```

Note: callers pass the full module path string e.g. `"use_cases/fold"` or `"adapters/window"`.

### `lua/application/helpers/make_controller_logged.lua` (controllers)

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

**Key properties:**
- The outer function is called normally at map-definition time — no log yet
- The returned closure is wrapped — log fires at keypress time with `args` captured via upvalue
- `args` = the opts passed at definition time, available when the key is pressed
- Non-function return values pass through as-is

## What changes

### Layer: Use cases

**Helper:** `make_logged`
**Module prefix:** `"use_cases/<name>"`

For each module:
1. Add `local make_logged = require("application.helpers.make_logged")`
2. Remove all manual `logger_use_case.debug(...)` calls (keep `.info`/`.warn`/`.error`)
3. Remove `logger_use_case` require if no longer used
4. Change `return M` → `return make_logged("use_cases/<name>", M)`

| File | arg |
|------|-----|
| `bookmarker.lua` | `"use_cases/bookmarker"` |
| `buffer.lua` | `"use_cases/buffer"` |
| `changer.lua` | `"use_cases/changer"` |
| `chatbot.lua` | `"use_cases/chatbot"` |
| `commander.lua` | `"use_cases/commander"` |
| `commenter.lua` | `"use_cases/commenter"` |
| `completer.lua` | `"use_cases/completer"` |
| `database.lua` | `"use_cases/database"` |
| `debugger.lua` | `"use_cases/debugger"` |
| `diagnostic.lua` | `"use_cases/diagnostic"` |
| `documentation.lua` | `"use_cases/documentation"` |
| `editor.lua` | `"use_cases/editor"` |
| `file.lua` | `"use_cases/file"` — keep `logger_use_case` for `.info`/`.error` |
| `fold.lua` | `"use_cases/fold"` |
| `formatter.lua` | `"use_cases/formatter"` |
| `hover.lua` | `"use_cases/hover"` |
| `jumper.lua` | `"use_cases/jumper"` |
| `layout.lua` | `"use_cases/layout"` |
| `linenumber.lua` | `"use_cases/linenumber"` |
| `lsp.lua` | `"use_cases/lsp"` |
| `notebook.lua` | `"use_cases/notebook"` |
| `noter.lua` | `"use_cases/noter"` |
| `outline.lua` | `"use_cases/outline"` |
| `pomodoro.lua` | `"use_cases/pomodoro"` |
| `quit.lua` | `"use_cases/quit"` |
| `rest.lua` | `"use_cases/rest"` |
| `screenshot.lua` | `"use_cases/screenshot"` |
| `searcher.lua` | `"use_cases/searcher"` |
| `selector.lua` | `"use_cases/selector"` |
| `statusline.lua` | `"use_cases/statusline"` |
| `terminal.lua` | `"use_cases/terminal"` |
| `tester.lua` | `"use_cases/tester"` |
| `theme.lua` | `"use_cases/theme"` |
| `todo.lua` | `"use_cases/todo"` |
| `toggler.lua` | `"use_cases/toggler"` |
| `tree.lua` | `"use_cases/tree"` |
| `versior.lua` | `"use_cases/versior"` |
| `window.lua` | `"use_cases/window"` |
| `workspace.lua` | `"use_cases/workspace"` |
| `zen.lua` | `"use_cases/zen"` |
| `zoom.lua` | `"use_cases/zoom"` |

**Skip:** `logger.lua`, `notification.lua`, `keymapper.lua`, `packager.lua`, `init.lua`

### Layer: Controllers

**Helper:** `make_controller_logged`
**Module prefix:** `"controllers/<name>"` (baked into the helper)

For each module:
1. Add `local make_controller_logged = require("application.helpers.make_controller_logged")`
2. Remove all manual `logger_use_case.debug(...)` calls from inside closures
3. Remove `logger_use_case` require
4. Change `return M` → `return make_controller_logged("<name>", M)`

Apply to every file in `lua/application/controllers/`.

### Layer: Adapters

**Helper:** `make_logged`
**Module prefix:** `"adapters/<name>"`

For each module:
1. Add `local make_logged = require("application.helpers.make_logged")`
2. Remove all manual `logger_use_case.debug(...)` calls
3. Remove `logger_use_case` require
4. Change `return M` → `return make_logged("adapters/<name>", M)`

Apply to every file in `lua/infrastructure/adapters/`.

## Verification

1. `make test` passes after all changes
2. Debug logs appear in development environment when keybindings are triggered
3. No manual `logger_use_case.debug` call remains in any controller, use case, or adapter body
