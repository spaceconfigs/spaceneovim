# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

SpaceNeoVim is a Neovim configuration framework inspired by Spacemacs. It uses Clean Architecture with three layers in `lua/`:

- **Domain** (`lua/domain/`) — Pure data: keybinding definitions (`maps/`), enums (`environments.lua`, `log_levels.lua`). No external dependencies.
- **Application** (`lua/application/`) — Use cases (`use_cases/`) orchestrate business logic; hooks (`hooks/`) handle lifecycle events (VimEnter, buffer open, etc.).
- **Infrastructure** (`lua/infrastructure/`) — Adapters wrap plugin APIs, plugins lazy-load actual Neovim plugins, events register autocmds.

Dependency direction: Domain ← Application ← Infrastructure.

## Bootstrap Sequence

`init.lua` → `config/default.lua` (vim options) → `application/use_cases` (packager, logger, notification, keymapper) → `infrastructure/events` (lifecycle, buffer, terminal). On VimEnter, `application/hooks/lifecycle.lua` loads theme, completer, notifications, and registers all keymaps.

## Key Patterns

**Use case** (`application/use_cases/foo.lua`): Exposes `M.setup()` to lazy-load adapter, logs via `logger_use_case`, delegates to `infrastructure/adapters/foo.lua`.

**Adapter** (`infrastructure/adapters/foo.lua`): Requires `infrastructure/plugins/foo.lua`, translates domain calls to plugin API calls.

**Plugin wrapper** (`infrastructure/plugins/foo.lua`): `pcall(require, "plugin-name")` with error handling. Returns plugin reference.

**Keybinding map** (`domain/maps/foo.lua`): Declarative table with `key`, `description`, `method` (function or vim cmd), optional `mode`. All maps loaded via `domain/maps/init.lua` and registered by keymapper use case through which-key.

## Plugin Management

Plugins managed by **lazy.nvim**. Plugin specs live in `lua/infrastructure/lazy/configs/init.lua` (large file with all specs). Lock file: `lazy-lock.json`. Leader key is `<Space>`.

Common plugin commands:
- `:Lazy` — open lazy.nvim UI
- `:Lazy update` — update all plugins
- `:Lazy sync` — sync plugins to lock file

## Adding a New Feature

1. Define keybindings in `lua/domain/maps/<feature>.lua`
2. Create use case in `lua/application/use_cases/<feature>.lua`
3. Create adapter in `lua/infrastructure/adapters/<feature>.lua`
4. Create plugin wrapper in `lua/infrastructure/plugins/<feature>.lua`
5. Add plugin spec to `lua/infrastructure/lazy/configs/init.lua`
6. Register the map file in `lua/domain/maps/init.lua`

## CI/CD

GitHub Actions workflow (`.github/workflows/main.yml`) auto-tags semver releases on pushes to `development` branch.
