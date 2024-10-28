# Lazy Dependency Registries Across All Layers

**Date:** 2026-06-10
**Status:** Approved design — pending implementation plan

## Problem

Only one layer edge currently resolves its dependencies through a lazy registry.
Use cases read adapters from `application.ports.registry` (a composition seam that
infrastructure populates at bootstrap). Every other edge wires dependencies a
different way:

| Edge | Current mechanism |
|---|---|
| use case → adapter | lazy registry: `require("application.ports.registry").keymapper()` ✅ |
| controller → use case | raw require: `require("application.use_cases.buffer")` |
| map → controller | `controllers` **injected as a function parameter**, threaded through every map |
| adapter → plugin | raw require: `require("infrastructure.plugins.buffer")` |

The goal is to make **all four edges resolve dependencies the same way the use
case → adapter edge already does**: through a lazy registry that carries a type
and is populated at bootstrap.

## Principle

For every edge, the **consumer's layer owns a registry module**. That module:

1. Declares the registry type (`---@class XRegistry` with resolver fields).
2. Exports an empty table: `local M = {} return M`.

A **composition step at bootstrap injects lazy resolvers** into the table:

```lua
for name, module in pairs(modules) do
  registry[name] = function()
    return require(module)
  end
end
```

Consumers resolve with a single call, binding the result to a local — exactly the
existing pattern in `application/use_cases/keymapper.lua`:

```lua
local adapter = require("application.ports.registry").keymapper()
```

Because resolvers are lazy, plugin lazy-loading is preserved and bootstrap
population order does not matter — only that all registries are filled before
VimEnter, when controllers and maps first load.

## Dependency directions (all preserved)

- `domain/contracts/registry` is **domain-owned**; `application` populates it.
  Application depends on domain ✅ — the domain never imports application.
- `application/ports/*` are **application-owned**; application/infrastructure
  populate them. Application never imports infrastructure ✅.
- `infrastructure/plugins/registry` is **infrastructure-owned**; infrastructure
  populates it ✅.

No layer imports upward. This mirrors the existing `PortRegistry`, which lives in
`application` (not `infrastructure`) precisely so use cases never import infra.

## The three changes

### 1. map → controller

This is the central change. `ControllerRegistry` is reshaped to work exactly like
`PortRegistry`.

- **`lua/domain/contracts/registry.lua`** stops being `---@meta` type-only and
  becomes a live module. It keeps the `---@class ControllerRegistry` block, but
  each field changes to resolver form:
  - before: `---@field buffer BufferContract`
  - after: `---@field buffer fun(): BufferContract`

  and the file gains a real export: `local M = {} return M`.

- **`lua/application/controllers/init.lua`** stops returning an eager table of
  required controllers. Instead it injects lazy resolvers into the domain
  registry, using the same `name → module` loop as
  `infrastructure/adapters/init.lua`.

- **Maps drop the `controllers` parameter.** `domain/maps/init.lua` calls each map
  with no argument. Each map resolves the controllers it needs at the top of the
  module:

  ```lua
  local buffer = require("domain.contracts.registry").buffer()
  -- ...
  { key = "d", description = "Close ([d]elete)", method = buffer.delete() }
  ```

- **`lua/application/hooks/lifecycle.lua`** changes from
  `require("domain.maps")(controllers)` to `require("domain.maps")()`, and the
  controller-registry population is triggered at bootstrap instead of being read
  as a return value here.

### 2. controller → use case

- **New `lua/application/ports/use_case_registry.lua`** — `---@class
  UseCaseRegistry` plus `local M = {} return M`. No `XUseCase` types exist in the
  codebase, so fields are typed loosely (`---@field buffer fun(): table`) rather
  than inventing a new type hierarchy. (YAGNI — typing can be tightened later if
  use-case interfaces are introduced.)

- **A composition step** (an application-internal wiring file) injects resolvers,
  keyed by use-case module name. Controllers depend on exactly one use case each
  (verified 1:1), so the mapping is direct.

- **Each controller** replaces its top-level
  `local buffer_use_case = require("application.use_cases.buffer")` with
  `local buffer_use_case = require("application.ports.use_case_registry").buffer()`.

### 3. adapter → plugin

- **New `lua/infrastructure/plugins/registry.lua`** — `---@class PluginRegistry`
  plus `local M = {} return M`. Plugin wrappers return varied shapes (e.g.
  `{ snacks = ... }`), so fields are typed loosely (`---@field buffer fun():
  table`).

- **A composition step** injects resolvers keyed by **plugin module filename**.
  Note plugin filenames do not all match adapter names (adapter `jumper` uses
  plugin `jump`; adapter `workspace` uses plugin `workspaces`; there is also
  `finder`, `org`). The registry is keyed by the plugin module that each adapter
  actually requires, not by adapter name.

- **Each adapter** replaces
  `local plugins = require("infrastructure.plugins.buffer")` with
  `local plugins = require("infrastructure.plugins.registry").buffer()`, leaving
  the rest of the adapter (`local snacks = plugins.snacks`) unchanged.

## Bootstrap wiring

`init.lua` currently runs: `config` → `infrastructure.adapters` (populates
`PortRegistry`) → `application.use_cases` → `infrastructure.events`.

It gains population calls for the three new registries alongside the existing
`require("infrastructure.adapters")`. Population order is irrelevant (lazy
resolvers); the only requirement is that all four registries are populated before
VimEnter, when `lifecycle.lua` loads controllers and maps.

## Scope

This touches a large number of files, all with the same mechanical change:

- ~40 adapters (swap one `require` line)
- ~40 controllers (swap one `require` line)
- ~25 map files (drop the `controllers` param, add top-level resolver requires,
  update call sites from `controllers.x.y()` to `x.y()`)
- 4 registry/composition modules (`domain/contracts/registry.lua`,
  `application/controllers/init.lua`, new `use_case_registry.lua` + its wiring,
  new `plugins/registry.lua` + its wiring)
- `init.lua` and `application/hooks/lifecycle.lua`

The plan should treat each edge as an **independent, separately shippable phase**,
starting with the controller registry (map → controller). Each phase keeps the
config bootable on its own.

## Non-goals (YAGNI)

- No new `XUseCase` or `XPlugin` type hierarchy — loose `fun(): table` typing.
- No change to the use case → adapter edge; `PortRegistry` already works.
- No change to plugin lazy-loading behavior — the lazy resolvers preserve it.
- No unrelated refactoring of controller/adapter/map internals beyond the
  dependency-resolution line(s).

## Risks / things to verify during implementation

- **Maps using many controllers** (`init.lua`, `unprefixed.lua`) need several
  top-level resolver requires; verify none reference a controller absent from the
  registry.
- **Plugin name mismatches** — build the plugin registry from the actual plugin
  module each adapter requires; do not assume adapter-name == plugin-name.
- **Bootstrap timing** — confirm all registries are populated before VimEnter
  (they are, if populated in `init.lua`).
