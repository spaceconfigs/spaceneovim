# Spec: Unit Testing Framework for SpaceNeoVim

## Problem

SpaceNeoVim has no automated tests. The codebase has 43 controllers, 23 map files, and multiple use cases — all untested. Regressions are caught only by manual use. The clean architecture makes most layers testable in isolation, but no test infrastructure exists.

## Goal

Introduce a unit testing framework that validates the structural contracts of each architectural layer without requiring a full Neovim runtime or plugin installation.

## Testing Tool: plenary.nvim busted

plenary.nvim is already a dependency (used by telescope, neogit, octo, etc.). It provides a busted-compatible test runner that runs inside headless Neovim, giving access to `vim.*` APIs without a GUI.

**Run command:**
```bash
nvim --headless -c "PlenaryBustedDirectory tests/ {minimal_init = 'tests/minimal_init.lua'}"
```

## Directory Structure

```
tests/
  minimal_init.lua
  domain/
    maps/
      map_contract_spec.lua       -- validates ALL map files structurally
  application/
    controllers/
      controller_contract_spec.lua -- validates ALL controllers structurally
      buffer_spec.lua              -- example: unit test with mocked use case
    use_cases/
      use_case_contract_spec.lua   -- validates ALL use cases structurally
```

## Minimal Init

`tests/minimal_init.lua` sets up the Lua module path so `require()` works without bootstrapping the full config. It also provides vim API stubs for modules that reference `vim.*` at load time.

```lua
-- Add the project lua/ directory to the module path
vim.opt.runtimepath:append(".")

-- Ensure plenary is loadable (lazy.nvim stores plugins here)
local plenary_path = vim.fn.stdpath("data") .. "/lazy/plenary.nvim"
vim.opt.runtimepath:append(plenary_path)
```

## Test Categories

### 1. Domain Map Contract Tests

**What:** Validate every map file returns a table of keybinding entries with the correct structure.

**Why:** Maps are pure data — the easiest layer to test and the most likely to break when controllers change.

**Contract:**
- Each map file returns a list (table of tables)
- Every entry has `key` (string), `description` (string), `method` (function)
- Optional fields: `mode` (string or table of strings), `buffer`, `silent`, `noremap`, `nowait`
- No entry has unexpected field types

**Example:**
```lua
describe("domain map contracts", function()
  local map_files = {
    "domain.maps.application",
    "domain.maps.buffer",
    "domain.maps.chatbot",
    "domain.maps.debugger",
    "domain.maps.error",
    "domain.maps.file",
    "domain.maps.git",
    "domain.maps.help",
    "domain.maps.jump",
    "domain.maps.layout",
    "domain.maps.major",
    "domain.maps.project",
    "domain.maps.quit",
    "domain.maps.search",
    "domain.maps.selector",
    "domain.maps.toggler",
    "domain.maps.ui",
    "domain.maps.unprefixed",
    "domain.maps.visual_mode",
    "domain.maps.window",
    "domain.maps.yank",
    "domain.maps.zoom",
  }

  for _, module_name in ipairs(map_files) do
    describe(module_name, function()
      local ok, map = pcall(require, module_name)

      it("loads without error", function()
        assert.is_true(ok, "Failed to require: " .. tostring(map))
      end)

      it("returns a table", function()
        assert.is_table(map)
      end)

      for i, entry in ipairs(map) do
        describe("entry " .. i, function()
          it("has a string key", function()
            assert.is_string(entry.key)
          end)

          it("has a string description", function()
            assert.is_string(entry.description)
          end)

          it("has a function or string method", function()
            local t = type(entry.method)
            assert.is_true(t == "function" or t == "string",
              "method is " .. t .. " for key '" .. entry.key .. "'")
          end)
        end)
      end
    end)
  end
end)
```

### 2. Controller Contract Tests

**What:** Validate every controller module exports functions that return functions (the currying contract).

**Why:** Controllers are the interface between maps and use cases. If a controller method doesn't return a function, the keybinding will break silently.

**Contract:**
- Module returns a table
- Every value in the table is a function
- Calling each function (with no args or empty table) returns a function

**Challenge:** Controllers `require()` use cases at load time, which `require()` adapters, which `require()` plugins. To test controllers in isolation, we need to mock the use case layer.

**Approach — package.loaded injection:**
```lua
-- Before requiring the controller, inject mock use cases
package.loaded["application.use_cases.buffer"] = {
  add = function() end,
  delete = function() end,
  close_others = function() end,
  list = function() end,
  next = function() end,
  previous = function() end,
  messages = function() end,
  reopen = function() end,
}
package.loaded["application.use_cases.logger"] = {
  debug = function() end,
  info = function() end,
  warn = function() end,
  error = function() end,
}

local controller = require("application.controllers.buffer")
```

**Example:**
```lua
describe("controller contracts", function()
  -- Pre-load logger mock (all controllers need this)
  package.loaded["application.use_cases.logger"] = {
    debug = function() end,
    info = function() end,
    warn = function() end,
    error = function() end,
  }

  describe("buffer controller", function()
    -- Mock the specific use case
    package.loaded["application.use_cases.buffer"] = {
      add = function() end,
      delete = function() end,
      close_others = function() end,
      list = function() end,
      next = function() end,
      previous = function() end,
      messages = function() end,
      reopen = function() end,
    }

    local controller = require("application.controllers.buffer")

    it("is a table", function()
      assert.is_table(controller)
    end)

    for name, method in pairs(controller) do
      it(name .. " returns a function", function()
        local result = method()
        assert.is_function(result)
      end)
    end
  end)
end)
```

### 3. Use Case Contract Tests

**What:** Validate every use case module exports a `setup` function and that all other exports are functions.

**Why:** Use cases are the business logic layer. Their contract is simpler — they just need to be callable functions (not curried).

**Contract:**
- Module returns a table
- Has a `setup` function (lazy-loads the adapter)
- All other exports are functions

**Challenge:** Same as controllers — use cases require adapters at setup time. Mock the adapter layer.

**Example:**
```lua
describe("use case contracts", function()
  describe("buffer use case", function()
    -- Mock the adapter
    package.loaded["infrastructure.adapters.buffer"] = {
      add = function() end,
      delete = function() end,
      close_others = function() end,
      list = function() end,
      next = function() end,
      previous = function() end,
      messages = function() end,
      reopen = function() end,
    }

    local use_case = require("application.use_cases.buffer")

    it("has a setup function", function()
      assert.is_function(use_case.setup)
    end)

    for name, method in pairs(use_case) do
      it(name .. " is a function", function()
        assert.is_function(method)
      end)
    end
  end)
end)
```

### 4. Individual Controller Unit Tests (with mocking)

**What:** Test that a controller method actually calls the use case with the correct arguments.

**Why:** Contract tests verify structure; unit tests verify behavior.

**Example:**
```lua
describe("terminal controller", function()
  local toggle_called_with = nil

  package.loaded["application.use_cases.logger"] = {
    debug = function() end,
  }
  package.loaded["application.use_cases.terminal"] = {
    toggle = function(opts)
      toggle_called_with = opts
    end,
  }

  local controller = require("application.controllers.terminal")

  it("toggle() passes options to use case", function()
    local opts = { type = "external" }
    local fn = controller.toggle(opts)
    fn()
    assert.are.same(opts, toggle_called_with)
  end)

  it("toggle() without options passes nil", function()
    toggle_called_with = "sentinel"
    local fn = controller.toggle()
    fn()
    assert.is_nil(toggle_called_with)
  end)
end)
```

## Mock Helper Module

To avoid repetitive mock setup, create a shared test helper:

`tests/helpers/mock.lua`:
```lua
local M = {}

--- Inject a mock module into package.loaded
--- @param module_path string e.g. "application.use_cases.buffer"
--- @param methods string[] list of method names to stub
--- @return table mock the mock object with call tracking
function M.mock_module(module_path, methods)
  local mock = { _calls = {} }
  for _, name in ipairs(methods) do
    mock[name] = function(...)
      table.insert(mock._calls, { method = name, args = { ... } })
    end
  end
  package.loaded[module_path] = mock
  return mock
end

--- Always-needed logger mock
function M.mock_logger()
  return M.mock_module("application.use_cases.logger", {
    "debug", "info", "warn", "error"
  })
end

--- Clear all mocks and cached modules for clean test isolation
--- @param patterns string[] module path prefixes to clear
function M.clear(patterns)
  for key, _ in pairs(package.loaded) do
    for _, pattern in ipairs(patterns) do
      if key:find(pattern, 1, true) == 1 then
        package.loaded[key] = nil
      end
    end
  end
end

return M
```

## Implementation Order

1. **Create `tests/minimal_init.lua`** — runtime path setup
2. **Create `tests/helpers/mock.lua`** — shared mock utilities
3. **Create `tests/domain/maps/map_contract_spec.lua`** — validates all 23 map files
4. **Create `tests/application/controllers/controller_contract_spec.lua`** — validates all 43 controllers
5. **Create `tests/application/controllers/buffer_spec.lua`** — example unit test with mocking
6. **Create `tests/application/use_cases/use_case_contract_spec.lua`** — validates all use cases
7. **Add a `Makefile` target** for running tests:
   ```makefile
   test:
   	nvim --headless -c "PlenaryBustedDirectory tests/ {minimal_init = 'tests/minimal_init.lua'}"
   ```

## Scope Boundaries

**In scope:**
- Structural contract tests for maps, controllers, and use cases
- Unit tests for controllers with mocked use cases
- Unit tests for use cases with mocked adapters
- Test helper for mocking and cleanup

**Out of scope (for now):**
- Integration tests requiring full Neovim bootstrap
- Adapter tests (require real plugins loaded)
- Plugin wrapper tests (thin pcall wrappers, low value)
- End-to-end keybinding tests (require simulated keypress)

## Verification

1. `make test` runs all tests and exits 0
2. Map contract tests cover all 23 map files
3. Controller contract tests cover all 43 controllers
4. At least one controller has a behavioral unit test with argument verification
5. Tests run in CI via the existing GitHub Actions workflow
