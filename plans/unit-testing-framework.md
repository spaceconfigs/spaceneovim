# Plan: Unit Testing Framework for SpaceNeoVim

## Context

SpaceNeoVim has 45 controllers, 45 use cases, and 23 map files with zero automated tests. The clean architecture makes layers independently testable but no test infrastructure exists. This plan implements the spec at `specs/unit-testing-framework.md` using plenary.nvim's busted test runner (already a dependency).

## Key Design Decisions

1. **Mock strategy:** Use `package.loaded` injection with metatable-based noop modules. Any field access returns a noop function — no need to enumerate methods per mock.
2. **Auto-discovery:** Contract tests find modules via `vim.fn.glob()` rather than hardcoded lists. New modules are automatically covered.
3. **Test isolation:** Plenary runs each `_spec.lua` in a separate Neovim process. Within a file, `mock.reset()` clears cached modules between `describe` blocks.
4. **Map test approach:** Mock all use cases + infrastructure, let controllers load normally against mocks. Maps then load and produce real closures.

## Implementation Steps

### Step 1: `tests/minimal_init.lua`
- Append `.` to `runtimepath` (makes `lua/` resolvable)
- Append `~/.local/share/nvim/lazy/plenary.nvim` to `runtimepath`
- Set `vim.fn.setenv("NVIM_ENVIRONMENT", "test")`

### Step 2: `tests/helpers/mock.lua`
Core mock utility. Every test depends on this.

Functions:
- **`M.create_noop_module()`** — Returns a table with `__index` metamethod that returns noop functions for any key. Avoids needing to know method names in advance.
- **`M.mock_module(path, methods?)`** — Injects mock into `package.loaded[path]`. If `methods` provided, creates spy functions with call tracking (`mock._calls`). If nil, uses noop metatable.
- **`M.mock_logger()`** — Shorthand for mocking `application.use_cases.logger`
- **`M.mock_use_case(name)`** — Shorthand for mocking `application.use_cases.<name>`
- **`M.mock_all_use_cases()`** — Auto-discovers and mocks all use cases via `vim.fn.glob("lua/application/use_cases/*.lua")`
- **`M.mock_all_controllers()`** — Same for controllers
- **`M.mock_infrastructure()`** — Mocks all adapters, plugins, events
- **`M.clear(patterns?)`** — Removes `package.loaded` entries matching prefixes (default: `application.`, `infrastructure.`, `domain.maps.`)
- **`M.reset()`** — `clear()` + re-inject logger mock

### Step 3: `tests/application/controllers/controller_contract_spec.lua`
Auto-discover all 45 controllers. For each:
1. `mock.reset()`
2. Mock the corresponding use case (filename convention matches)
3. `require()` the controller
4. Assert: module is a table, every value is a function
5. Assert: calling each function with no args returns a function (currying contract)

**Critical files:** All files in `lua/application/controllers/*.lua`

### Step 4: `tests/application/controllers/buffer_spec.lua`
Behavioral unit test demonstrating spy pattern:
1. Create spy mocks for logger and buffer use case (with call tracking)
2. For each of the 8 methods (`add`, `delete`, `close_others`, `list`, `next`, `previous`, `messages`, `reopen`):
   - Call outer function → get closure
   - Call closure → assert logger.debug called with correct `{ module, func }`
   - Assert use case method called

**Critical file:** `lua/application/controllers/buffer.lua`

### Step 5: `tests/application/use_cases/use_case_contract_spec.lua`
Auto-discover all use cases (excluding `init.lua`). For each:
1. `mock.reset()` + `mock.mock_infrastructure()`
2. Mock cross-dependencies (notification for logger, logger for keymapper)
3. `require()` the use case
4. Assert: module is a table, every value is a function
5. Do NOT require `setup` to exist (4 use cases lack it: keymapper, packager, linenumber, init)

**Critical files:** All files in `lua/application/use_cases/*.lua`

### Step 6: `tests/domain/maps/map_contract_spec.lua`
Auto-discover all map files (excluding `init.lua`). For each:
1. `mock.reset()` + `mock.mock_all_use_cases()` + `mock.mock_infrastructure()`
2. `require()` the map (controllers load normally against mocked use cases)
3. Handle two return shapes:
   - **Flat list** (most maps): validate each entry has `key` (string), `description` (string)
   - **Single entry with `content`** (`visual_mode.lua`): validate outer entry + content entries
4. `method` may be nil (group headers like `{ key = "v", description = "Version control" }` in `git.lua`)
5. When `method` exists, assert it is a function
6. When `mode` exists, assert string or table of strings

**Critical files:** All files in `lua/domain/maps/*.lua`, especially:
- `lua/domain/maps/visual_mode.lua` (different return shape)
- `lua/domain/maps/git.lua` (group headers without method)
- `lua/domain/maps/unprefixed.lua` (calls `vim.keymap.set` at load time — works in headless)

### Step 7: `Makefile`
```makefile
.PHONY: test test-domain test-controllers test-use-cases

test:
	nvim --headless -c "PlenaryBustedDirectory tests/ {minimal_init = 'tests/minimal_init.lua'}"

test-domain:
	nvim --headless -c "PlenaryBustedDirectory tests/domain/ {minimal_init = 'tests/minimal_init.lua'}"

test-controllers:
	nvim --headless -c "PlenaryBustedDirectory tests/application/controllers/ {minimal_init = 'tests/minimal_init.lua'}"

test-use-cases:
	nvim --headless -c "PlenaryBustedDirectory tests/application/use_cases/ {minimal_init = 'tests/minimal_init.lua'}"
```

### Step 8: CI integration (optional)
Add test job to `.github/workflows/main.yml`:
- Install Neovim via AppImage
- Clone plenary.nvim to data directory
- Run `make test`

## File Summary

| File | Purpose |
|------|---------|
| `tests/minimal_init.lua` | Runtime path setup for headless test execution |
| `tests/helpers/mock.lua` | Metatable-based mock factory + cleanup utilities |
| `tests/application/controllers/controller_contract_spec.lua` | All 45 controllers return curried functions |
| `tests/application/controllers/buffer_spec.lua` | Behavioral test with spy assertions |
| `tests/application/use_cases/use_case_contract_spec.lua` | All use cases export callable functions |
| `tests/domain/maps/map_contract_spec.lua` | All 23 maps have valid entry structure |
| `Makefile` | Test runner targets |

## Verification

1. `make test` exits 0 with all tests passing
2. Contract tests auto-discover and cover all modules (no hardcoded lists to maintain)
3. Behavioral test (buffer_spec) verifies logger + use case delegation
4. Adding a new controller/use case/map is automatically covered by contract tests
