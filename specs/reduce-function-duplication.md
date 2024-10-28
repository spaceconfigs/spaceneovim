# Spec: Reduce function duplication across all layers

## Problem

Most modules duplicate near-identical functions that differ only by a single parameter (direction, axis, type). This creates maintenance burden, increases the chance of inconsistency, and inflates line count without adding clarity.

**Worst offenders by duplication severity:**

| Module   | Functions | Duplicated Groups                                                                     | Layer Impact                    |
| -------- | --------- | ------------------------------------------------------------------------------------- | ------------------------------- |
| window   | 24        | 5 groups (go, move, move_far, resize, split)                                          | use_case + adapter + controller |
| debugger | 24        | 3 groups (step, frame, list)                                                          | use_case + adapter + controller |
| lsp      | 17        | 1 group (navigation: declaration/definition/implementation/references/typedefinition) | use_case + adapter + controller |
| notebook | 18        | 2 groups (send\_\*, toggle_output)                                                    | use_case + adapter + controller |
| chatbot  | 9         | 1 group (all follow identical provider pattern)                                       | use_case + adapter + controller |
| editor   | 9         | 3 pairs (drag, paragraph, paste)                                                      | use_case + adapter + controller |
| buffer   | 8         | All pure delegation                                                                   | use_case + adapter              |
| file     | 10        | 1 group (search variants)                                                             | use_case + adapter              |

**Additional systemic duplication:**

- **Every controller** repeats identical logging + currying boilerplate per method
- **Every adapter** repeats identical logging boilerplate per method

## Target State

### 1. Use cases: parameterized functions replace directional variants

Current (`window.lua`):

```lua
M.go_left = function()
	local adapter = M.setup()
	adapter.go_left()
end

M.go_right = function()
	local adapter = M.setup()
	adapter.go_right()
end

M.go_up = function()
	local adapter = M.setup()
	adapter.go_up()
end

M.go_down = function()
	local adapter = M.setup()
	adapter.go_down()
end
```

Target:

```lua
M.go = function(direction)
	local adapter = M.setup()
	adapter.go(direction)
end
```

### 2. Use cases: resize accepts axis and delta

Current:

```lua
M.shrink_height = function()
	vim.api.nvim_win_set_height(0, vim.api.nvim_win_get_height(0) + 5)
end

M.expand_height = function()
	vim.api.nvim_win_set_height(0, vim.api.nvim_win_get_height(0) - 5)
end
```

Target:

```lua
M.resize = function(opts)
	local axis = opts.axis -- "height" or "width"
	local delta = opts.delta -- positive = grow, negative = shrink
	local getter = axis == "height" and vim.api.nvim_win_get_height or vim.api.nvim_win_get_width
	local setter = axis == "height" and vim.api.nvim_win_set_height or vim.api.nvim_win_set_width
	setter(0, getter(0) + delta)
end
```

### 3. Adapters: parameterized dispatch replaces per-direction methods

Current (`adapters/window.lua`):

```lua
M.go_right = function()
	local message = { module = "adapters/window", func = "go_right" }
	logger_use_case.debug(message)
	vim.cmd("wincmd l")
end

M.go_left = function()
	local message = { module = "adapters/window", func = "go_left" }
	logger_use_case.debug(message)
	vim.cmd("wincmd h")
end
```

Target:

```lua
local go_commands = { left = "h", right = "l", up = "k", down = "j" }

M.go = function(direction)
	local message = { module = "adapters/window", func = "go", direction = direction }
	logger_use_case.debug(message)
	vim.cmd("wincmd " .. go_commands[direction])
end
```

### 4. Controllers: pass parameters through currying

Current (`controllers/window.lua`):

```lua
M.go_left = function()
	return function()
		local message = { module = "controllers/window", func = "go_left" }
		logger_use_case.debug(message)
		window_use_case.go_left()
	end
end

M.go_right = function()
	return function()
		local message = { module = "controllers/window", func = "go_right" }
		logger_use_case.debug(message)
		window_use_case.go_right()
	end
end
```

Target:

```lua
M.go = function(opts)
	return function()
		local message = { module = "controllers/window", func = "go", opts = opts }
		logger_use_case.debug(message)
		window_use_case.go(opts.direction)
	end
end
```

### 5. Maps: pass parameter at keybinding definition time

Current (`maps/window.lua`):

```lua
{ key = "h", description = "Go left ([h])", method = window_controller.go_left() },
{ key = "j", description = "Go down ([j])", method = window_controller.go_down() },
{ key = "k", description = "Go up ([k])", method = window_controller.go_up() },
{ key = "l", description = "Go right ([l])", method = window_controller.go_right() },
```

Target:

```lua
{ key = "h", description = "Go left ([h])", method = window_controller.go({ direction = "left" }) },
{ key = "j", description = "Go down ([j])", method = window_controller.go({ direction = "down" }) },
{ key = "k", description = "Go up ([k])", method = window_controller.go({ direction = "up" }) },
{ key = "l", description = "Go right ([l])", method = window_controller.go({ direction = "right" }) },
```

## Modules to refactor

### Critical (5+ duplicated functions)

#### window (use_case, adapter, controller, map)

| Current Functions                                                 | Collapsed To          | Parameter                          |
| ----------------------------------------------------------------- | --------------------- | ---------------------------------- |
| `go_left`, `go_right`, `go_up`, `go_down`                         | `go(direction)`       | `"left"` `"right"` `"up"` `"down"` |
| `move_left`, `move_right`, `move_up`, `move_down`                 | `move(direction)`     | `"left"` `"right"` `"up"` `"down"` |
| `move_far_left`, `move_far_right`, `move_far_up`, `move_far_down` | `move_far(direction)` | `"left"` `"right"` `"up"` `"down"` |
| `shrink_height`, `expand_height`, `shrink_width`, `expand_width`  | `resize(opts)`        | `{ axis, delta }`                  |
| `split`, `vsplit`, `split_previous`, `vsplit_previous`            | `split(opts)`         | `{ type, previous }`               |

#### debugger (use_case, adapter, controller, map)

| Current Functions                                 | Collapsed To    | Parameter                             |
| ------------------------------------------------- | --------------- | ------------------------------------- |
| `step_over`, `step_into`, `step_out`, `step_back` | `step(type)`    | `"over"` `"into"` `"out"` `"back"`    |
| `go_up`, `go_down`                                | `go(direction)` | `"up"` `"down"`                       |
| `list_breakpoints`, `list_frames`, `list_scopes`  | `list(type)`    | `"breakpoints"` `"frames"` `"scopes"` |

#### lsp (use_case, adapter, controller, map)

| Current Functions                                                             | Collapsed To           | Parameter                           |
| ----------------------------------------------------------------------------- | ---------------------- | ----------------------------------- |
| `declaration`, `definition`, `implementation`, `references`, `typedefinition` | `navigate(type, opts)` | `"declaration"` `"definition"` etc. |

#### notebook (use_case, adapter, controller, map)

| Current Functions                                                         | Collapsed To | Parameter                         |
| ------------------------------------------------------------------------- | ------------ | --------------------------------- |
| `send_motion`, `send_line`, `send_file`, `send_until_cursor`, `send_mark` | `send(type)` | `"motion"` `"line"` `"file"` etc. |

#### editor (use_case, adapter, controller, map)

| Current Functions                      | Collapsed To           | Parameter             |
| -------------------------------------- | ---------------------- | --------------------- |
| `drag_up`, `drag_down`                 | `drag(opts)`           | `{ direction, mode }` |
| `next_paragraph`, `previous_paragraph` | `paragraph(direction)` | `"next"` `"previous"` |
| `paste_before`, `paste_after`          | `paste(position)`      | `"before"` `"after"`  |

### Moderate (2-4 duplicated functions)

#### chatbot (use_case, adapter, controller, map)

All methods follow identical `opts` delegation — no collapse needed since they represent distinct operations, but the adapter default-value pattern should be cleaned up per spec `reduce-adapter-defaults`.

#### fold (use_case, adapter, controller, map)

| Current                   | Collapsed            | Parameter                     |
| ------------------------- | -------------------- | ----------------------------- |
| `open`, `close`, `toggle` | `fold(action, opts)` | `"open"` `"close"` `"toggle"` |

#### linenumber (use_case, adapter, controller, map)

| Current                              | Collapsed      | Parameter                 |
| ------------------------------------ | -------------- | ------------------------- |
| `toggle_absolute`, `toggle_relative` | `toggle(type)` | `"absolute"` `"relative"` |

#### screenshot (use_case, adapter, controller, map)

| Current        | Collapsed       | Parameter         |
| -------------- | --------------- | ----------------- |
| `copy`, `save` | `capture(type)` | `"copy"` `"save"` |

#### quit (use_case, adapter, controller, map)

| Current           | Collapsed    | Parameter  |
| ----------------- | ------------ | ---------- |
| `all`, `save_all` | `quit(opts)` | `{ save }` |

## What NOT to change

- **Maps layer**: Maps remain declarative tables. The only change is calling parameterized controller methods instead of per-direction ones.
- **Domain enums**: Do not create direction/type enums unless they are reused across 3+ modules.
- **Modules with 1-3 genuinely distinct functions**: If functions have different signatures or logic, don't force-collapse them (e.g., `tree.toggle`, `tree.focus`, `tree.find` are distinct operations).
- **Controller currying pattern**: Each controller method still returns a closure. The refactor reduces the number of methods, not the pattern itself.

## Verification

1. All existing unit tests (`make test`) continue to pass after updating test expectations
2. All keybindings produce the same runtime behavior
3. No new `require()` cycles introduced
4. Contract tests still auto-discover and validate all modules
