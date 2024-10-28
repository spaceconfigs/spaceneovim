# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

SpaceNeoVim is a Neovim configuration framework inspired by Spacemacs. It uses Clean Architecture with four layers in `lua/`:

- **Domain** (`lua/domain/`) — Pure data: keybinding definitions (`maps/`), enums (`environments.lua`, `log_levels.lua`), contracts (`contracts/`, including the controller registry seam `contracts/registry.lua` and hook registry seam `contracts/hook_registry.lua`). No external dependencies, no `vim.*`.
- **Application** (`lua/application/`) — Use cases (`usecases/`) orchestrate business logic, ports (`ports/`) expose registries (`ports/registry.lua` for adapters, `ports/usecase_registry.lua` for use cases), helpers (`helpers/`) provide logging proxies.
- **Presentation** (`lua/presentation/`) — Controllers (`controllers/`) handle keybinding input (currying + logging) and delegate to use cases; hooks (`hooks/`) handle lifecycle events (VimEnter, buffer open, terminal, etc.). Interface Adapters ring: pure delegation, no framework (`vim.*`) code.
- **Infrastructure** (`lua/infrastructure/`) — Adapters wrap plugin APIs, plugins lazy-load actual Neovim plugins, events register autocmds and dispatch to presentation hooks via the domain hook registry.

Dependency direction: Domain ← Application ← { Presentation, Infrastructure }. Each layer's `init.lua` wires its concrete modules into a registry seam as lazy resolvers, so inner layers never import outer layers directly: controllers → `domain/contracts/registry.lua`, hooks → `domain/contracts/hook_registry.lua`, adapters → `application/ports/registry.lua`, use cases → `application/ports/usecase_registry.lua`.

## Bootstrap Sequence

`init.lua` → `config` (vim options) → `infrastructure/plugins` → `infrastructure/adapters` (populate port registry) → `presentation/controllers` (populate controller registry) → `application/usecases` (populate use-case registry, run one-time setups) → `presentation/hooks` (populate hook registry) → `infrastructure/events` (register autocmds). On VimEnter, `presentation/hooks/lifecycle.lua` loads theme, completer, notifications, and registers all keymaps.

## Key Patterns

**Controller** (`presentation/controllers/foo.lua`): Accepts params at map-definition time, returns a closure for keypress execution. Resolves its use case via `require("application.ports.usecase_registry").foo()`, delegates to it, and is wrapped in `make_controller_logged` so every keypress logs. Every controller method follows: `M.method = function(opts) return function() use_case.method(opts) end end`.

**Use case** (`application/usecases/foo.lua`): Exposes `M.setup()` that resolves the adapter via `require("application.ports.registry").foo()`, executes business logic directly (no currying), and is wrapped in `make_logged`. Never requires infrastructure directly.

**Hook** (`presentation/hooks/foo.lua`): Handles lifecycle events by delegating to use cases. Dispatched by `infrastructure/events/foo.lua`, which resolves it via `require("domain.contracts.hook_registry").foo()`.

Hook names follow the Angular/NestJS lifecycle convention `<timing>_<subject>_<event>` (snake_case):
- `on` — reacting to an event as it happens (like `ngOnInit` / `onModuleInit`)
- `after` — post-phase timing, fires once a phase has completed (like `ngAfterViewInit` / `onApplicationBootstrap`)
- `before` — pre-phase timing, fires ahead of a phase (like `beforeApplicationShutdown`)

| Phase | Hook |
|---|---|
| Buffer/filetype initialization | `on_buffer_init()`, `on_filetype_init()` |
| Terminal lifecycle | `on_terminal_open()`, `on_terminal_output()`, `on_terminal_destroy()` |
| Debugger session start/stop | `on_debugger_activate()`, `on_debugger_deactivate()` |
| Everything wired up (VimEnter) | `after_application_init()` |

New hooks must follow this pattern — pick the timing prefix (`on` / `after` / `before`), then the subject (`buffer`, `terminal`, `application`, …), then the event (`init`, `open`, `destroy`, …).

**Adapter** (`infrastructure/adapters/foo.lua`): Requires `infrastructure/plugins/foo.lua`, translates domain calls to plugin API calls.

**Plugin wrapper** (`infrastructure/plugins/foo.lua`): `pcall(require, "plugin-name")` with error handling. Returns plugin reference.

**Keybinding map** (`domain/maps/foo.lua`): Declarative table with `key`, `description`, `method` (controller function call that returns a function), optional `mode`. All maps loaded via `domain/maps/init.lua` and registered by keymapper use case through which-key. Maps resolve their controller via `require("domain.contracts.registry").foo()` — never by requiring presentation or use cases. No raw vim commands or `vim.*` references.

## Plugin Management

Plugins managed by **lazy.nvim**. Plugin specs live in `lua/infrastructure/plugins/lazy/configs/init.lua` (large file with all specs). Lock file: `lazy-lock.json`. Leader key is `<Space>`.

Common plugin commands:
- `:Lazy` — open lazy.nvim UI
- `:Lazy update` — update all plugins
- `:Lazy sync` — sync plugins to lock file

## Adding a New Feature

1. Define the controller contract in `lua/domain/contracts/<feature>.lua` and add its resolver field to `domain/contracts/registry.lua`
2. Define keybindings in `lua/domain/maps/<feature>.lua` (resolve controller via `domain.contracts.registry`)
3. Create controller in `lua/presentation/controllers/<feature>.lua` (currying, use case via `usecase_registry`)
4. Create use case in `lua/application/usecases/<feature>.lua` (business logic, adapter via `ports.registry`)
5. Create adapter in `lua/infrastructure/adapters/<feature>.lua`
6. Create plugin wrapper in `lua/infrastructure/plugins/<feature>.lua`
7. Add plugin spec to `lua/infrastructure/plugins/lazy/configs/init.lua`
8. Register the map file in `lua/domain/maps/init.lua`, the controller in `presentation/controllers/init.lua`, the use case in `application/usecases/init.lua`, and the adapter in `infrastructure/adapters/init.lua`

## CI/CD

GitHub Actions workflow (`.github/workflows/main.yml`) auto-tags semver releases on pushes to `development` branch.
