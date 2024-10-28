# Lazy Dependency Registries Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make every layer edge resolve its dependencies through a lazy registry populated at bootstrap, exactly like use cases already resolve adapters through `application.ports.registry`.

**Architecture:** Each consumer's layer owns a registry module that declares a `---@class` type and exports an empty `local M = {} return M` table. A composition step at bootstrap injects lazy resolvers (`registry[name] = function() return require(module) end`). Consumers resolve with `require(...).name()`. Three edges change: map→controller, controller→use_case, adapter→plugin. Each phase is independently shippable and leaves the config bootable.

**Tech Stack:** Neovim 0.12 Lua config, lazy.nvim plugin manager. The repo is symlinked as `~/.config/nvim`, so `nvim --headless` boots this config directly. There is no unit-test framework — verification is a headless boot plus Lua asserts against the registries.

---

## Verification model (read once)

There are no unit tests. Every "test" step in this plan is a **headless boot assertion**. The repo is `~/.config/nvim`, so a bare `nvim --headless` runs `init.lua` (which populates the registries at bootstrap) and then we assert against them with `-c "lua ..."`.

The canonical smoke command (used throughout, adapted per phase):

```bash
nvim --headless -c "lua print('BUILD ' .. #require('domain.maps')())" -c "qa" 2>&1
```

`#require('domain.maps')()` builds the full keybinding set. Building maps invokes the controller resolvers, which in turn load controllers, which resolve their use cases — so a successful, non-zero map build exercises the map→controller and controller→use_case edges end to end.

Any Lua error (registry not populated, missing field, nil method) prints a stack trace to stderr and the assert fails. A clean run prints `BUILD 288` (or similar) and nothing else.

---

## Phase 1 — map → controller registry

This is the central change. `ControllerRegistry` becomes a live, lazily-populated module that mirrors `PortRegistry`. Maps stop receiving the `controllers` parameter and resolve controllers via `require`.

All of Phase 1's edits must land in a single commit: changing `controllers/init.lua`'s shape breaks `lifecycle.lua` until the maps are migrated. Do every step, then verify, then commit once.

### Task 1.1: Convert the controller registry contract into a live resolver module

**Files:**
- Modify: `lua/domain/contracts/registry.lua` (currently `---@meta` type-only, 49 lines)

The file currently declares `---@class ControllerRegistry` with fields typed as the contract directly (`---@field buffer BufferContract`) and has no runtime export. Change every field to **resolver form** and add a real export, exactly like `lua/application/ports/registry.lua`.

- [ ] **Step 1: Rewrite the file**

Replace the entire contents with:

```lua
--- Domain-owned controller registry (composition seam). The application layer
--- populates these resolvers at bootstrap; domain maps read their controller from
--- here (require("domain.contracts.registry").<name>()) instead of importing
--- application controllers. Mirrors application/ports/registry.lua (PortRegistry).
---@class ControllerRegistry
---@field bookmarker fun(): BookmarkerContract
---@field buffer fun(): BufferContract
---@field changer fun(): ChangerContract
---@field chatbot fun(): ChatbotContract
---@field commander fun(): CommanderContract
---@field commenter fun(): CommenterContract
---@field completer fun(): CompleterContract
---@field database fun(): DatabaseContract
---@field debugger fun(): DebuggerContract
---@field diagnostic fun(): DiagnosticContract
---@field documentation fun(): DocumentationContract
---@field editor fun(): EditorContract
---@field file fun(): FileContract
---@field fold fun(): FoldContract
---@field formatter fun(): FormatterContract
---@field hover fun(): HoverContract
---@field jumper fun(): JumperContract
---@field layout fun(): LayoutContract
---@field linenumber fun(): LinenumberContract
---@field lsp fun(): LspContract
---@field notebook fun(): NotebookContract
---@field noter fun(): NoterContract
---@field notification fun(): NotificationContract
---@field outline fun(): OutlineContract
---@field packager fun(): PackagerContract
---@field pomodoro fun(): PomodoroContract
---@field quit fun(): QuitContract
---@field rest fun(): RestContract
---@field screenshot fun(): ScreenshotContract
---@field searcher fun(): SearcherContract
---@field selector fun(): SelectorContract
---@field statusline fun(): StatuslineContract
---@field terminal fun(): TerminalContract
---@field tester fun(): TesterContract
---@field theme fun(): ThemeContract
---@field todo fun(): TodoContract
---@field toggler fun(): TogglerContract
---@field tree fun(): TreeContract
---@field versior fun(): VersiorContract
---@field window fun(): WindowContract
---@field workspace fun(): WorkspaceContract
---@field zen fun(): ZenContract
---@field zoom fun(): ZoomContract
local M = {}

return M
```

(Note: the `---@meta` line is removed — this is now a real module, not a type-only stub.)

### Task 1.2: Populate the controller registry from `controllers/init.lua`

**Files:**
- Modify: `lua/application/controllers/init.lua` (currently returns an eager table of `require`d controllers)

Rewrite it to inject lazy resolvers into the domain registry, exactly like `lua/infrastructure/adapters/init.lua` does for `PortRegistry`.

- [ ] **Step 1: Rewrite the file**

Replace the entire contents with:

```lua
--- Composition root: wires concrete application controllers into the domain
--- ControllerRegistry as LAZY resolvers (nothing is required until first called).
--- Must run at bootstrap before maps resolve a controller.

local registry = require("domain.contracts.registry")

--- Controller name → module that provides its concrete controller.
local modules = {
  bookmarker = "application.controllers.bookmarker",
  buffer = "application.controllers.buffer",
  changer = "application.controllers.changer",
  chatbot = "application.controllers.chatbot",
  commander = "application.controllers.commander",
  commenter = "application.controllers.commenter",
  completer = "application.controllers.completer",
  database = "application.controllers.database",
  debugger = "application.controllers.debugger",
  diagnostic = "application.controllers.diagnostic",
  documentation = "application.controllers.documentation",
  editor = "application.controllers.editor",
  file = "application.controllers.file",
  fold = "application.controllers.fold",
  formatter = "application.controllers.formatter",
  hover = "application.controllers.hover",
  jumper = "application.controllers.jumper",
  layout = "application.controllers.layout",
  linenumber = "application.controllers.linenumber",
  lsp = "application.controllers.lsp",
  notebook = "application.controllers.notebook",
  noter = "application.controllers.noter",
  notification = "application.controllers.notification",
  outline = "application.controllers.outline",
  packager = "application.controllers.packager",
  pomodoro = "application.controllers.pomodoro",
  quit = "application.controllers.quit",
  rest = "application.controllers.rest",
  screenshot = "application.controllers.screenshot",
  searcher = "application.controllers.searcher",
  selector = "application.controllers.selector",
  statusline = "application.controllers.statusline",
  terminal = "application.controllers.terminal",
  tester = "application.controllers.tester",
  theme = "application.controllers.theme",
  todo = "application.controllers.todo",
  toggler = "application.controllers.toggler",
  tree = "application.controllers.tree",
  versior = "application.controllers.versior",
  window = "application.controllers.window",
  workspace = "application.controllers.workspace",
  zen = "application.controllers.zen",
  zoom = "application.controllers.zoom",
}

for name, module in pairs(modules) do
  registry[name] = function()
    return require(module)
  end
end
```

(This no longer `return`s a value — like `infrastructure/adapters/init.lua`, its job is the side effect of populating the registry.)

### Task 1.3: Trigger population at bootstrap and update the lifecycle hook

**Files:**
- Modify: `lua/init.lua` (add population trigger)
- Modify: `lua/application/hooks/lifecycle.lua:3-4` (drop the `controllers` local, call `require("domain.maps")()`)

Wait — `init.lua` lives at the repo root (`/home/dan/Projects/spaceneovim/init.lua`), not under `lua/`. Confirm with the existing path before editing.

- [ ] **Step 1: Add the controller-registry population to bootstrap**

In `init.lua`, after the existing `require("infrastructure.adapters")` line (line 23), add a line so the controller registry is populated at bootstrap (before VimEnter, when maps load):

```lua
require("config")
require("infrastructure.adapters")
require("application.controllers")
require("application.use_cases")
require("infrastructure.events")
```

(The new line is `require("application.controllers")`. Because its resolvers are lazy, this only registers closures — no controllers are loaded yet.)

- [ ] **Step 2: Update the lifecycle hook to stop injecting controllers**

In `lua/application/hooks/lifecycle.lua`, change the top two lines:

Before:
```lua
local controllers = require("application.controllers")
local maps = require("domain.maps")(controllers)
```

After:
```lua
local maps = require("domain.maps")()
```

Leave the rest of `lifecycle.lua` unchanged.

### Task 1.4: Migrate every map to resolve controllers via the registry

**Files (all in `lua/domain/maps/`):** `application.lua`, `buffer.lua`, `chatbot.lua`, `debugger.lua`, `error.lua`, `file.lua`, `git.lua`, `help.lua`, `init.lua`, `jump.lua`, `layout.lua`, `major.lua`, `project.lua`, `quit.lua`, `search.lua`, `selector.lua`, `toggler.lua`, `ui.lua`, `unprefixed.lua`, `visual_mode.lua`, `window.lua`, `yank.lua`, `zoom.lua`

**The uniform transformation for each map file** (except `init.lua`, handled separately in Step 3):

1. At the top of the file, add one resolver local per controller the file uses:
   `local <ctrl> = require("domain.contracts.registry").<ctrl>()`
2. Change the signature `return function(controllers)` → `return function()`.
3. Replace every `controllers.<ctrl>.` with `<ctrl>.` in the body.

The `---@param controllers ControllerRegistry` annotation line above the function should be removed (the function now takes no args).

- [ ] **Step 1: Worked example — `lua/domain/maps/buffer.lua`**

This file uses only the `buffer` controller. Apply the transformation:

Before (lines 1-7):
```lua
local clone = require("domain.utils.table").clone
---@param controllers ControllerRegistry
---@return KeyBind[]
return function(controllers)
	---@type KeyBind[]
	local buffer_content = {
		{ key = "<C-d>", description = "Close others ([d]elete)", method = controllers.buffer.close_others() },
```

After:
```lua
local clone = require("domain.utils.table").clone
local buffer = require("domain.contracts.registry").buffer()
---@return KeyBind[]
return function()
	---@type KeyBind[]
	local buffer_content = {
		{ key = "<C-d>", description = "Close others ([d]elete)", method = buffer.close_others() },
```

and every other `controllers.buffer.X()` in the file becomes `buffer.X()`.

- [ ] **Step 2: Apply the same transformation to the remaining map files**

Use this table to know which resolver locals to add at the top of each file (one `local <name> = require("domain.contracts.registry").<name>()` per entry). Then strip the param and replace `controllers.<name>.` → `<name>.` throughout.

| File | Resolver locals to add |
|---|---|
| `application.lua` | `changer`, `chatbot`, `documentation`, `todo` |
| `chatbot.lua` | `chatbot` |
| `debugger.lua` | `debugger` |
| `error.lua` | `diagnostic` |
| `file.lua` | `bookmarker`, `file`, `packager`, `tree` |
| `git.lua` | `versior` |
| `help.lua` | *(none — uses no controller; just drop the `controllers` param and the `---@param` line)* |
| `jump.lua` | `jumper` |
| `layout.lua` | `layout` |
| `major.lua` | `database`, `diagnostic`, `formatter`, `hover`, `lsp`, `notebook`, `noter`, `outline`, `pomodoro`, `rest`, `screenshot`, `searcher`, `tester` |
| `project.lua` | `terminal`, `workspace` |
| `quit.lua` | `quit` |
| `search.lua` | `searcher`, `workspace` |
| `selector.lua` | `selector` |
| `toggler.lua` | `linenumber`, `statusline`, `toggler` |
| `ui.lua` | `theme` |
| `unprefixed.lua` | `completer`, `editor`, `hover`, `jumper` |
| `visual_mode.lua` | `jumper` |
| `window.lua` | `notification`, `window`, `zen` |
| `yank.lua` | `jumper` |
| `zoom.lua` | `fold`, `zoom` |

Note: `visual_mode.lua` is not currently required by `domain/maps/init.lua`; migrate it anyway for consistency so it doesn't break if wired in later.

- [ ] **Step 3: Migrate `lua/domain/maps/init.lua`**

This file is the orchestrator: it both defines its own `default_map` (using controllers `commander`, `window`, `commenter`, `buffer`, `terminal`) and calls every sub-map. It currently calls sub-maps as `map(controllers)`.

Apply three changes:

(a) Add resolver locals after the existing requires at the top (after line 22, the `zoom_map` require):
```lua
local buffer = require("domain.contracts.registry").buffer()
local commander = require("domain.contracts.registry").commander()
local commenter = require("domain.contracts.registry").commenter()
local terminal = require("domain.contracts.registry").terminal()
local window = require("domain.contracts.registry").window()
```

(b) Change the signature and remove the `---@param` line:
```lua
---@return KeyBind[]
return function()
```

(c) In `default_map`, replace `controllers.commander.`, `controllers.window.`, `controllers.commenter.`, `controllers.buffer.`, `controllers.terminal.` with the bare locals (`commander.`, `window.`, `commenter.`, `buffer.`, `terminal.`).

(d) In the loop that calls sub-maps (the `for _, map in ipairs({ ... }) do` block near the bottom), change `map(controllers)` to `map()`.

### Task 1.5: Verify Phase 1 and commit

- [ ] **Step 1: Boot headless and assert the controller registry resolves and maps build**

Run:
```bash
nvim --headless -c "lua assert(type(require('domain.contracts.registry').buffer) == 'function', 'controller registry not populated'); assert(type(require('domain.contracts.registry').buffer()) == 'table', 'buffer controller did not resolve'); print('MAPS ' .. #require('domain.maps')())" -c "qa" 2>&1
```
Expected: prints `MAPS 288` (or the current count) and **no** Lua error / stack trace.

- [ ] **Step 2: Grep for leftover param-style references**

Run:
```bash
grep -rn "function(controllers)" lua/domain/maps/ && echo "LEFTOVERS FOUND" || echo "clean"
grep -rn "controllers\." lua/domain/maps/ && echo "LEFTOVERS FOUND" || echo "clean"
```
Expected: both print `clean` (no matches).

- [ ] **Step 3: Commit**

```bash
git add lua/domain/contracts/registry.lua lua/application/controllers/init.lua lua/application/hooks/lifecycle.lua lua/domain/maps/ init.lua
git commit -m "refactor: resolve controllers in maps via domain controller registry"
```

---

## Phase 2 — controller → use_case registry

Controllers depend on exactly one use case each, 1:1 by name. Replace each controller's raw `require("application.use_cases.X")` with a registry resolution.

### Task 2.1: Create the use-case registry module

**Files:**
- Create: `lua/application/ports/use_case_registry.lua`

No `XUseCase` types exist, so fields are typed loosely as `fun(): table` (YAGNI — tighten later if use-case interfaces are introduced).

- [ ] **Step 1: Create the file**

```lua
--- Application-owned use-case registry (composition seam). Populated at bootstrap;
--- controllers read their use case from here
--- (require("application.ports.use_case_registry").<name>()) instead of importing
--- the use-case module directly. Mirrors application/ports/registry.lua.
--- No XUseCase types exist yet, so resolvers are typed loosely.
---@class UseCaseRegistry
---@field bookmarker fun(): table
---@field buffer fun(): table
---@field changer fun(): table
---@field chatbot fun(): table
---@field commander fun(): table
---@field commenter fun(): table
---@field completer fun(): table
---@field database fun(): table
---@field debugger fun(): table
---@field diagnostic fun(): table
---@field documentation fun(): table
---@field editor fun(): table
---@field file fun(): table
---@field fold fun(): table
---@field formatter fun(): table
---@field hover fun(): table
---@field jumper fun(): table
---@field layout fun(): table
---@field linenumber fun(): table
---@field lsp fun(): table
---@field notebook fun(): table
---@field noter fun(): table
---@field notification fun(): table
---@field outline fun(): table
---@field packager fun(): table
---@field pomodoro fun(): table
---@field quit fun(): table
---@field rest fun(): table
---@field screenshot fun(): table
---@field searcher fun(): table
---@field selector fun(): table
---@field statusline fun(): table
---@field terminal fun(): table
---@field tester fun(): table
---@field theme fun(): table
---@field todo fun(): table
---@field toggler fun(): table
---@field tree fun(): table
---@field versior fun(): table
---@field window fun(): table
---@field workspace fun(): table
---@field zen fun(): table
---@field zoom fun(): table
local M = {}

return M
```

### Task 2.2: Populate the use-case registry at bootstrap

**Files:**
- Modify: `lua/application/use_cases/init.lua` (currently requires a handful of use cases to run their setup; runs at bootstrap via `init.lua`'s `require("application.use_cases")`)

Add the population loop. Keep the existing setup `require`s — they serve a different purpose (running `setup()` side effects).

- [ ] **Step 1: Prepend the population loop**

At the **top** of `lua/application/use_cases/init.lua`, before the existing `require("application.use_cases.packager")` lines, add:

```lua
local registry = require("application.ports.use_case_registry")

local modules = {
  bookmarker = "application.use_cases.bookmarker",
  buffer = "application.use_cases.buffer",
  changer = "application.use_cases.changer",
  chatbot = "application.use_cases.chatbot",
  commander = "application.use_cases.commander",
  commenter = "application.use_cases.commenter",
  completer = "application.use_cases.completer",
  database = "application.use_cases.database",
  debugger = "application.use_cases.debugger",
  diagnostic = "application.use_cases.diagnostic",
  documentation = "application.use_cases.documentation",
  editor = "application.use_cases.editor",
  file = "application.use_cases.file",
  fold = "application.use_cases.fold",
  formatter = "application.use_cases.formatter",
  hover = "application.use_cases.hover",
  jumper = "application.use_cases.jumper",
  layout = "application.use_cases.layout",
  linenumber = "application.use_cases.linenumber",
  lsp = "application.use_cases.lsp",
  notebook = "application.use_cases.notebook",
  noter = "application.use_cases.noter",
  notification = "application.use_cases.notification",
  outline = "application.use_cases.outline",
  packager = "application.use_cases.packager",
  pomodoro = "application.use_cases.pomodoro",
  quit = "application.use_cases.quit",
  rest = "application.use_cases.rest",
  screenshot = "application.use_cases.screenshot",
  searcher = "application.use_cases.searcher",
  selector = "application.use_cases.selector",
  statusline = "application.use_cases.statusline",
  terminal = "application.use_cases.terminal",
  tester = "application.use_cases.tester",
  theme = "application.use_cases.theme",
  todo = "application.use_cases.todo",
  toggler = "application.use_cases.toggler",
  tree = "application.use_cases.tree",
  versior = "application.use_cases.versior",
  window = "application.use_cases.window",
  workspace = "application.use_cases.workspace",
  zen = "application.use_cases.zen",
  zoom = "application.use_cases.zoom",
}

for name, module in pairs(modules) do
  registry[name] = function()
    return require(module)
  end
end
```

- [ ] **Step 2: Confirm every listed module exists**

Run:
```bash
cd /home/dan/Projects/spaceneovim
for n in bookmarker buffer changer chatbot commander commenter completer database debugger diagnostic documentation editor file fold formatter hover jumper layout linenumber lsp notebook noter notification outline packager pomodoro quit rest screenshot searcher selector statusline terminal tester theme todo toggler tree versior window workspace zen zoom; do test -f "lua/application/use_cases/$n.lua" || echo "MISSING: $n"; done; echo "check done"
```
Expected: prints only `check done` (no `MISSING:` lines). If a module is missing, remove that line from the `modules` table and from the corresponding controller migration in Task 2.3.

### Task 2.3: Migrate every controller to resolve its use case via the registry

**Files (all in `lua/application/controllers/`):** every `*.lua` except `init.lua`.

Each controller has exactly one line of the form
`local <x>_use_case = require("application.use_cases.<x>")`.
Replace the require target only — keep the local variable name so the rest of the controller is untouched.

- [ ] **Step 1: Worked example — `lua/application/controllers/buffer.lua`**

Before (line 2):
```lua
local buffer_use_case = require("application.use_cases.buffer")
```
After:
```lua
local buffer_use_case = require("application.ports.use_case_registry").buffer()
```

- [ ] **Step 2: Apply to all controllers**

For each controller file, change `require("application.use_cases.<name>")` to `require("application.ports.use_case_registry").<name>()`, where `<name>` is the use-case name already present in that file's require line. The mapping is 1:1 with the controller name for every controller (e.g. `file.lua` → `.file()`, `lsp.lua` → `.lsp()`).

A mechanical sweep that performs this for all controllers:
```bash
cd /home/dan/Projects/spaceneovim
for f in lua/application/controllers/*.lua; do
  [ "$(basename "$f")" = "init.lua" ] && continue
  perl -0pi -e 's{require\("application\.use_cases\.([a-z_]+)"\)}{require("application.ports.use_case_registry").$1()}g' "$f"
done
echo "sweep done"
```
After running, spot-check `lua/application/controllers/file.lua` shows the new form.

### Task 2.4: Verify Phase 2 and commit

- [ ] **Step 1: Boot headless and assert the use-case registry resolves**

Run:
```bash
nvim --headless -c "lua assert(type(require('application.ports.use_case_registry').buffer) == 'function', 'use_case registry not populated'); assert(type(require('application.ports.use_case_registry').buffer()) == 'table', 'buffer use case did not resolve'); print('MAPS ' .. #require('domain.maps')())" -c "qa" 2>&1
```
Expected: prints `MAPS 288` and no error. (Building maps loads controllers, which now resolve use cases through the registry — so this exercises the new edge.)

- [ ] **Step 2: Grep for leftover raw use-case requires in controllers**

Run:
```bash
grep -rn 'require("application.use_cases.' lua/application/controllers/ && echo "LEFTOVERS FOUND" || echo "clean"
```
Expected: `clean`.

- [ ] **Step 3: Commit**

```bash
git add lua/application/ports/use_case_registry.lua lua/application/use_cases/init.lua lua/application/controllers/
git commit -m "refactor: resolve use cases in controllers via use-case registry"
```

---

## Phase 3 — adapter → plugin registry

Adapters require plugin wrappers directly. Replace with registry resolution. **The registry is keyed by plugin module name, not adapter name** — some adapters use a differently-named plugin (`commander`→`file`, `jumper`→`jump`, `packager`→`lazy`, `workspace`→`workspaces`) and `debugger` uses two (`debugger`, `file`).

### Task 3.1: Create the plugin registry module

**Files:**
- Create: `lua/infrastructure/plugins/registry.lua`

Keyed by the distinct plugin modules that adapters require. Plugin wrappers return varied shapes (e.g. `{ snacks = ... }`), so fields are typed loosely.

- [ ] **Step 1: Create the file**

```lua
--- Infrastructure-owned plugin registry (composition seam). Populated at bootstrap;
--- adapters read their plugin wrapper from here
--- (require("infrastructure.plugins.registry").<name>()) instead of importing the
--- plugin wrapper directly. Keyed by plugin MODULE name (not adapter name).
--- Resolvers are typed loosely because wrappers return varied shapes.
---@class PluginRegistry
---@field bookmarker fun(): table
---@field buffer fun(): table
---@field changer fun(): table
---@field chatbot fun(): table
---@field commenter fun(): table
---@field completer fun(): table
---@field composer fun(): table
---@field database fun(): table
---@field debugger fun(): table
---@field diagnostic fun(): table
---@field documentation fun(): table
---@field file fun(): table
---@field fold fun(): table
---@field formatter fun(): table
---@field hover fun(): table
---@field jump fun(): table
---@field keymapper fun(): table
---@field layout fun(): table
---@field lazy fun(): table
---@field logger fun(): table
---@field lsp fun(): table
---@field notebook fun(): table
---@field noter fun(): table
---@field notification fun(): table
---@field outline fun(): table
---@field pomodoro fun(): table
---@field rest fun(): table
---@field screenshot fun(): table
---@field searcher fun(): table
---@field selector fun(): table
---@field statusline fun(): table
---@field terminal fun(): table
---@field tester fun(): table
---@field theme fun(): table
---@field todo fun(): table
---@field tree fun(): table
---@field versior fun(): table
---@field window fun(): table
---@field workspaces fun(): table
---@field zen fun(): table
---@field zoom fun(): table
local M = {}

return M
```

### Task 3.2: Populate the plugin registry at bootstrap

**Files:**
- Create: `lua/infrastructure/plugins/init.lua`
- Modify: `init.lua` (require the new composition at bootstrap)

- [ ] **Step 1: Create the composition file**

`lua/infrastructure/plugins/init.lua`:
```lua
--- Composition root: wires plugin wrappers into the PluginRegistry as LAZY
--- resolvers (the wrapper is only required on first call, preserving plugin
--- lazy-loading). Keyed by plugin MODULE name. Must run at bootstrap.

local registry = require("infrastructure.plugins.registry")

local modules = {
  bookmarker = "infrastructure.plugins.bookmarker",
  buffer = "infrastructure.plugins.buffer",
  changer = "infrastructure.plugins.changer",
  chatbot = "infrastructure.plugins.chatbot",
  commenter = "infrastructure.plugins.commenter",
  completer = "infrastructure.plugins.completer",
  composer = "infrastructure.plugins.composer",
  database = "infrastructure.plugins.database",
  debugger = "infrastructure.plugins.debugger",
  diagnostic = "infrastructure.plugins.diagnostic",
  documentation = "infrastructure.plugins.documentation",
  file = "infrastructure.plugins.file",
  fold = "infrastructure.plugins.fold",
  formatter = "infrastructure.plugins.formatter",
  hover = "infrastructure.plugins.hover",
  jump = "infrastructure.plugins.jump",
  keymapper = "infrastructure.plugins.keymapper",
  layout = "infrastructure.plugins.layout",
  lazy = "infrastructure.plugins.lazy",
  logger = "infrastructure.plugins.logger",
  lsp = "infrastructure.plugins.lsp",
  notebook = "infrastructure.plugins.notebook",
  noter = "infrastructure.plugins.noter",
  notification = "infrastructure.plugins.notification",
  outline = "infrastructure.plugins.outline",
  pomodoro = "infrastructure.plugins.pomodoro",
  rest = "infrastructure.plugins.rest",
  screenshot = "infrastructure.plugins.screenshot",
  searcher = "infrastructure.plugins.searcher",
  selector = "infrastructure.plugins.selector",
  statusline = "infrastructure.plugins.statusline",
  terminal = "infrastructure.plugins.terminal",
  tester = "infrastructure.plugins.tester",
  theme = "infrastructure.plugins.theme",
  todo = "infrastructure.plugins.todo",
  tree = "infrastructure.plugins.tree",
  versior = "infrastructure.plugins.versior",
  window = "infrastructure.plugins.window",
  workspaces = "infrastructure.plugins.workspaces",
  zen = "infrastructure.plugins.zen",
  zoom = "infrastructure.plugins.zoom",
}

for name, module in pairs(modules) do
  registry[name] = function()
    return require(module)
  end
end
```

Note: `require("infrastructure.plugins")` resolves to this `init.lua`. The `lazy` entry points at the `infrastructure/plugins/lazy/` directory's `init.lua`.

- [ ] **Step 2: Trigger population at bootstrap**

In `init.lua`, add `require("infrastructure.plugins")` before `require("infrastructure.adapters")` (adapters resolve plugins, so populate plugins first — though with lazy resolvers, order is not strictly required):

```lua
require("config")
require("infrastructure.plugins")
require("infrastructure.adapters")
require("application.controllers")
require("application.use_cases")
require("infrastructure.events")
```

- [ ] **Step 3: Confirm every listed plugin module exists**

Run:
```bash
cd /home/dan/Projects/spaceneovim
for n in bookmarker buffer changer chatbot commenter completer composer database debugger diagnostic documentation file fold formatter hover jump keymapper layout logger lsp notebook noter notification outline pomodoro rest screenshot searcher selector statusline terminal tester theme todo tree versior window workspaces zen zoom; do test -f "lua/infrastructure/plugins/$n.lua" || echo "MISSING: $n"; done; test -d "lua/infrastructure/plugins/lazy" && echo "lazy dir ok" || echo "MISSING: lazy dir"; echo "check done"
```
Expected: prints `lazy dir ok` and `check done`, no `MISSING:` lines.

### Task 3.3: Migrate every adapter to resolve its plugin via the registry

**Files (all in `lua/infrastructure/adapters/`):** every `*.lua` except `init.lua`. (Ignore `test.lua` and `mapper.lua` — they are not wired into `adapters/init.lua`; leave them as-is.)

Each adapter has one or more lines `local <var> = require("infrastructure.plugins.<plugin>")`. Replace the require target with the registry resolution, keyed by the same `<plugin>` name; keep the local variable name.

- [ ] **Step 1: Worked example — `lua/infrastructure/adapters/buffer.lua`**

Before (line 2):
```lua
local plugins = require("infrastructure.plugins.buffer")
```
After:
```lua
local plugins = require("infrastructure.plugins.registry").buffer()
```
The rest of the adapter (`local snacks = plugins.snacks`) is unchanged.

- [ ] **Step 2: Worked example with a name mismatch — `lua/infrastructure/adapters/debugger.lua`**

This adapter requires **two** plugins (`debugger` and `file`). Both lines transform by plugin name:
```lua
require("infrastructure.plugins.debugger")  -->  require("infrastructure.plugins.registry").debugger()
require("infrastructure.plugins.file")      -->  require("infrastructure.plugins.registry").file()
```

- [ ] **Step 3: Apply to all adapters via a mechanical sweep**

```bash
cd /home/dan/Projects/spaceneovim
for f in lua/infrastructure/adapters/*.lua; do
  base="$(basename "$f")"
  [ "$base" = "init.lua" ] && continue
  [ "$base" = "test.lua" ] && continue
  [ "$base" = "mapper.lua" ] && continue
  perl -0pi -e 's{require\("infrastructure\.plugins\.([a-z_]+)"\)}{require("infrastructure.plugins.registry").$1()}g' "$f"
done
echo "sweep done"
```

This rewrites `require("infrastructure.plugins.<name>")` → `require("infrastructure.plugins.registry").<name>()` everywhere, correctly handling the name-mismatch and two-plugin cases because it keys off the captured plugin name. Note the regex deliberately does not match `infrastructure.plugins.registry` itself (it has no further `.<name>` segment in a `require("...")` of the bare module), but to be safe confirm in Step 4 that no double-rewrite occurred.

### Task 3.4: Verify Phase 3 and commit

- [ ] **Step 1: Guard against a double-rewritten registry require**

Run:
```bash
grep -rn 'plugins.registry").registry()' lua/infrastructure/adapters/ && echo "DOUBLE-REWRITE FOUND" || echo "clean"
```
Expected: `clean`. (If found, that adapter required the registry by accident — revert that one line.)

- [ ] **Step 2: Boot headless and assert the plugin registry resolves and an adapter loads through it**

Run:
```bash
nvim --headless -c "lua assert(type(require('infrastructure.plugins.registry').buffer) == 'function', 'plugin registry not populated'); assert(type(require('infrastructure.adapters.buffer')) == 'table', 'buffer adapter did not load'); print('MAPS ' .. #require('domain.maps')())" -c "qa" 2>&1
```
Expected: prints `MAPS 288` and no error. (Requiring the buffer adapter forces it through `require("infrastructure.plugins.registry").buffer()` → loads the snacks/bufferline plugins, proving the edge works.)

- [ ] **Step 3: Grep for leftover raw plugin requires in adapters**

Run:
```bash
grep -rn 'require("infrastructure.plugins.[a-z_]*")' lua/infrastructure/adapters/ | grep -v 'plugins.registry' && echo "LEFTOVERS FOUND" || echo "clean"
```
Expected: `clean` (every plugin require now goes through `.registry`).

- [ ] **Step 4: Commit**

```bash
git add lua/infrastructure/plugins/registry.lua lua/infrastructure/plugins/init.lua lua/infrastructure/adapters/ init.lua
git commit -m "refactor: resolve plugins in adapters via plugin registry"
```

---

## Final integration check

- [ ] **Step 1: Full headless boot, all three edges at once**

Run:
```bash
nvim --headless -c "lua print('CTRL '  .. tostring(type(require('domain.contracts.registry').buffer())))" \
                 -c "lua print('UC '    .. tostring(type(require('application.ports.use_case_registry').buffer())))" \
                 -c "lua print('PLUGIN '.. tostring(type(require('infrastructure.plugins.registry').buffer)))" \
                 -c "lua print('MAPS '  .. #require('domain.maps')())" \
                 -c "qa" 2>&1
```
Expected output (order may vary), no error:
```
CTRL table
UC table
PLUGIN function
MAPS 288
```

- [ ] **Step 2: Interactive sanity (manual, optional)**

Open `nvim` normally and confirm `<Space>` opens which-key and a few bindings (e.g. `<Space>b b` for buffers, `<Space>f f` for files) still work. This is the real end-to-end check that registries resolve under actual keypresses.

---

## Notes / self-review

- **Spec coverage:** all three edges from the spec each have a phase (map→controller = Phase 1, controller→use_case = Phase 2, adapter→plugin = Phase 3); bootstrap wiring and dependency-direction preservation are covered by Tasks 1.3 / 2.2 / 3.2. ✅
- **Phase independence:** each phase touches a disjoint set of consumer files (maps / controllers / adapters) and only appends to `init.lua`. Any phase can ship alone and the config still boots.
- **No 1:1 assumption for plugins:** Phase 3 keys the registry by plugin module name and uses a capture-based sweep, so `commander`→`file`, `jumper`→`jump`, `packager`→`lazy`, `workspace`→`workspaces`, and `debugger`→`debugger`+`file` all transform correctly.
- **Type looseness is intentional:** `UseCaseRegistry` and `PluginRegistry` use `fun(): table` because no `XUseCase`/`XPlugin` types exist (spec non-goal: don't invent a type hierarchy).
- **Branch:** all commits land on `refactor/lazy-dependency-registries` (already created) to avoid the `development` auto-tag CI.
```
