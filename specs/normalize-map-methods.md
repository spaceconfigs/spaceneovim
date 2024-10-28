# Spec: Normalize map methods to always return a function

## Problem

The `method` field in `lua/domain/maps/*.lua` uses 6 different patterns inconsistently:

| Pattern | Example | Files |
|---------|---------|-------|
| Use case call with args (returns function) | `use_case.edit({ provider = "claudecode" })` | chatbot.lua:7, error.lua:5, git.lua:8 |
| Use case reference (no args) | `jumper_use_case.timer` | jump.lua:4, buffer.lua:4, layout.lua:4 |
| Raw vim ex-command string | `":confirm qall<cr>"` | quit.lua:2, window.lua:29, toggler.lua:13 |
| Vim key sequence string | `"}"`, `"<C-w>"`, `":m .+1==<CR>"` | unprefixed.lua:13-50 |
| Inline anonymous function | `function() workspace_use_case.add() end` | project.lua:18, unprefixed.lua:57 |
| Direct vim.* reference | `vim.lsp.buf.rename` | major.lua:66, major.lua:107 |

Only the first pattern (use case call returning a function) follows the Clean Architecture convention.

## Target State

Every map entry's `method` must call a use case function that **returns a function**:

```lua
-- CORRECT: chatbot.lua:7 (reference pattern)
{ key = "e", description = "Edit with AI", method = use_case.edit({ provider = "claudecode" }) }
```

The use case function returns a function that the keymapper executes when the keybinding is triggered.

## What needs to change

### 1. Raw vim commands → use case functions

Current (`quit.lua`):
```lua
{ key = "q", description = "Quit all", method = ":confirm qall<cr>" }
```

Target:
```lua
{ key = "q", description = "Quit all", method = quit_use_case.all() }
```

The use case wraps the vim command and returns a function.

### 2. Vim key sequences → use case functions

Current (`unprefixed.lua`):
```lua
{ key = "}", description = "Next paragraph", method = "}" }
```

Target:
```lua
{ key = "}", description = "Next paragraph", method = navigation_use_case.next_paragraph() }
```

### 3. Direct vim.* references → use case functions

Current (`major.lua`):
```lua
{ key = "r", description = "Rename", method = vim.lsp.buf.rename }
```

Target:
```lua
{ key = "r", description = "Rename", method = lsp_use_case.rename() }
```

### 4. Inline anonymous functions → use case functions

Current (`project.lua:18`):
```lua
{ key = "a", description = "Add workspace", method = function() workspace_use_case.add(); tree_use_case.toggle()() end }
```

Target:
```lua
{ key = "a", description = "Add workspace", method = workspace_use_case.add_and_toggle_tree() }
```

### 5. Use case references without args — keep or wrap

Current (`jump.lua:4`):
```lua
{ key = "t", description = "Timer", method = jumper_use_case.timer }
```

These are acceptable **only if** the reference itself is already a function. If it's a function that needs to be called to return a function, it must be called:

```lua
{ key = "t", description = "Timer", method = jumper_use_case.timer() }
```

## Files affected

All 20 map files in `lua/domain/maps/`:
- `chatbot.lua` — already correct (reference pattern)
- `error.lua`, `git.lua`, `search.lua`, `file.lua` — mostly correct, may have exceptions
- `quit.lua` — all raw strings
- `window.lua` — mix of use case calls and raw strings
- `toggler.lua` — mix of use case references and raw strings
- `unprefixed.lua` — mostly raw strings/key sequences
- `major.lua` — mix of use case calls, vim.* references, and raw strings
- `project.lua` — has inline function
- `jump.lua`, `buffer.lua`, `layout.lua`, `debugger.lua`, `yank.lua`, `help.lua`, `ui.lua`, `selector.lua`, `visual_mode.lua`, `zoom.lua` — use case references (verify they return functions)

New use cases and adapters may need to be created for vim commands/key sequences that don't yet have a use case wrapper.

## Verification

1. Every `method` field in `lua/domain/maps/*.lua` is a function call to a use case (no raw strings, no `vim.*` references, no inline functions)
2. Each use case function returns a function
3. Neovim starts without errors
4. All keybindings work as before
