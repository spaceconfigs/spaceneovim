# Extract a `presentation/` layer for controllers

**Date:** 2026-06-10
**Status:** Approved

## Goal

Move controllers out of the Application layer into a new top-level `presentation/`
layer, aligning the codebase with Clean Architecture's Interface Adapters ring
(ring 3: Controllers + Presenters). No behavior change — purely structural.

## Rationale

Controllers are pure interface adapters: they do currying + logging and delegate to
use-case ports, with **zero framework code** (no `vim.*`, no plugin requires). That is
the signature of ring 3 (Interface Adapters), distinct from both Application use cases
(ring 2) and Infrastructure / Frameworks & Drivers (ring 4). A dedicated `presentation/`
layer makes that boundary explicit.

Hooks were considered for the move and **deliberately left in `application/`**: they
manipulate `vim.api` directly (framework-coupled) and `lifecycle.lua` is a bootstrap
orchestrator — neither is a pure interface adapter.

## Resulting dependency graph

```
Domain ← Application ← { Presentation, Infrastructure }
```

Presentation and Infrastructure are both outer layers depending inward. Presentation
depends on Application (use-case registry, helpers) and Domain (contracts registry).
Nothing inner imports presentation directly — controllers are wired in via the
`domain.contracts.registry` composition seam.

## Changes

### Moves (45 files, content unchanged)
- `lua/application/controllers/*.lua` (44) → `lua/presentation/controllers/*.lua`
- `lua/application/controllers/init.lua` (composition root) → `lua/presentation/controllers/init.lua`

Controllers' internal requires stay pointed at `application.ports.use_case_registry`
and `application.helpers.make_controller_logged` (both remain in `application/`).
`presentation → application` is a valid inward dependency.

### Reference edits
1. **`lua/presentation/controllers/init.lua`** — `modules` map: 44 values
   `application.controllers.X` → `presentation.controllers.X`.
2. **`init.lua:25`** — `require("application.controllers")` → `require("presentation.controllers")`.
3. **`lua/application/hooks/terminal.lua`** — remove direct
   `require("application.controllers.chatbot")`; resolve via the seam at call time
   inside `onOpen`: `require("domain.contracts.registry").chatbot()`. Removes the
   would-be `application → presentation` violation.
4. **`lua/domain/contracts/registry.lua`** — doc comment: "application controllers"
   → "presentation controllers".

### Docs
Update `CLAUDE.md`: Project Overview layer list, the Controller entry under Key
Patterns, and step 2 of "Adding a New Feature" (path change).

## Verification
```
nvim --headless "+lua require('presentation.controllers'); print('ok')" +qa
```
plus `grep -rn "application.controllers" lua/ init.lua` returning no stray references.
