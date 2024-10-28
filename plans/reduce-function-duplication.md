# Plan: Reduce Function Duplication Across All Layers

## Context

SpaceNeoVim modules duplicate near-identical functions that differ only by a direction/type/axis parameter. The spec at `specs/reduce-function-duplication.md` defines the target state. This plan implements it module by module, bottom-up (adapter → use_case → controller → map), running tests after each module.

## Implementation Order

Process each module as a single unit across all 4 layers before moving to the next.

### Step 1: window (24 → 9 functions)

**Files:**

- `lua/infrastructure/adapters/window.lua`
- `lua/application/use_cases/window.lua`
- `lua/application/controllers/window.lua`
- `lua/domain/maps/window.lua`

**Adapter changes:**

- `go_left/right/up/down` → `go(direction)` with dispatch: `{left="h", right="l", up="k", down="j"}` → `vim.cmd("wincmd " .. map[direction])`
- `move_left/right/up/down` → `move(direction)` → `vim.cmd("WinShift " .. direction)`
- `move_far_left/right/up/down` → `move_far(direction)` → `vim.cmd("WinShift far_" .. direction)`
- `split/vsplit/split_previous/vsplit_previous` → `split(opts)` with `opts.type` ("split"/"vsplit") and `opts.previous` (bool). Command: `type .. (previous and " | wincmd p" or "")`
- Keep unchanged: `toggle`, `go_to(number)`, `close`, `dedicate`

**Use case changes:**

- `go(direction)`, `move(direction)`, `move_far(direction)`, `split(opts)` → delegate to adapter
- `shrink_height/expand_height/shrink_width/expand_width` → `resize(opts)` with `opts.axis` ("height"/"width") and `opts.delta` (number, positive=grow negative=shrink)
- Keep unchanged: `toggle`, `go_to(number)`, `close`, `balance_area`, `dedicate`

**Controller changes:** Each collapsed function accepts opts, returns closure with logging, delegates to use case. E.g. `M.go = function(opts) return function() ... window_use_case.go(opts.direction) end end`

**Map changes:** Calls become `window_controller.go({ direction = "left" })`, `window_controller.resize({ axis = "height", delta = 5 })`, etc.

### Step 2: debugger (23 → 18 functions)

**Files:**

- `lua/infrastructure/adapters/debugger.lua`
- `lua/application/use_cases/debugger.lua`
- `lua/application/controllers/debugger.lua`
- `lua/domain/maps/debugger.lua`

**Collapse:**

- `step_over/into/out/back` → `step(type)` → `dap["step_" .. type]()` (note: step_back = `dap.step_back()` fits same pattern)
- `go_up/go_down` → `go(direction)` → dispatch: `{up = dap.up, down = dap.down}`
- Keep everything else unchanged (each has genuinely different implementation)

### Step 3: lsp (18 → 13 functions)

**Files:**

- `lua/infrastructure/adapters/lsp.lua`
- `lua/application/use_cases/lsp.lua`
- `lua/application/controllers/lsp.lua`
- `lua/domain/maps/major.lua`

**Collapse:**

- `declaration/definition/implementation/references/typedefinition` → `navigate(type, options)` with dispatch table:
  ```
  declaration → snacks.picker.lsp_declarations()
  definition → snacks.picker.lsp_definitions()
  implementation → vim.lsp.buf.implementation()
  references → snacks.picker.lsp_references()
  typedefinition → vim.lsp.buf.type_definition()
  ```
  Remote branch uses same dispatch wrapped in `jumper_use_case.timer`

**Remove duplicates:**

- `show_references` (duplicate of `navigate("references")`) → remove
- `type_definition` (duplicate of `navigate("typedefinition")`) → remove
- Update any map references to use `navigate` instead

### Step 4: editor (9 → 6 functions)

**Files:**

- `lua/infrastructure/adapters/editor.lua`
- `lua/application/use_cases/editor.lua`
- `lua/application/controllers/editor.lua`
- `lua/domain/maps/unprefixed.lua`

**Collapse:**

- `drag_up/drag_down` → `drag(opts)` with `opts.direction` and `opts.mode`
- `next_paragraph/previous_paragraph` → `paragraph(direction)`
- `paste_before/paste_after` → `paste(position)`
- Keep unchanged: `delete_word`, `terminal_escape`, `noop`

### Step 5: fold (3 → 1 function)

**Files:**

- `lua/infrastructure/adapters/fold.lua`
- `lua/application/use_cases/fold.lua`
- `lua/application/controllers/fold.lua`
- Map references (in `lua/domain/maps/major.lua` or similar)

**Collapse:**

- `open/close/toggle` → `fold(action, opts)` where action is `"open"/"close"/"toggle"`

### Step 6: linenumber (2 → 1 function)

**Files:**

- `lua/application/use_cases/linenumber.lua` (has direct vim.opt logic, no adapter)
- `lua/application/controllers/linenumber.lua`
- Map references

**Collapse:**

- `toggle_absolute/toggle_relative` → `toggle(type)`

### Step 7: screenshot (2 → 1 function)

**Files:**

- `lua/infrastructure/adapters/screenshot.lua`
- `lua/application/use_cases/screenshot.lua`
- `lua/application/controllers/screenshot.lua`
- Map references

**Collapse:**

- `copy/save` → `capture(type, options)`

### Step 8: quit (2 → 1 function)

**Files:**

- `lua/infrastructure/adapters/quit.lua`
- `lua/application/use_cases/quit.lua`
- `lua/application/controllers/quit.lua`
- `lua/domain/maps/quit.lua`

**Collapse:**

- `all/save_all` → `quit(opts)` with `opts.save` boolean

### Step 9: Run full test suite

Run `make test` and fix any contract test failures. The auto-discovery tests will catch missing methods or broken return shapes.

## Constraints

- Controller currying pattern (return closure) stays
- Map declarative table structure stays
- Every function still logs with module/func in both controller and adapter
- Use `opts` table pattern consistently for all parameterized functions
- Don't create domain enums for directions/types unless reused across 3+ modules

## Verification

1. `make test` passes after each module (118+ tests)
2. All keybindings produce same runtime behavior
3. No new `require()` cycles
