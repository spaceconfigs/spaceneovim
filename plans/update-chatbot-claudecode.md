# Plan: Update chatbot to claudecode.nvim with Spacemacs keybindings

## Context

Per `specs/update-chatbot-claudecode.md`, update the chatbot layer to use `coder/claudecode.nvim` with Spacemacs-style keybindings. Keep the existing `<leader>$d` prefix. The plugin is already in lazy specs. The adapter already maps most actions to ClaudeCode commands.

## Step 1: Uncomment claudecode in plugin wrapper

**File:** `infrastructure/plugins/chatbot.lua`

- Uncomment `require("claudecode")` and its error check
- Uncomment `claudecode` in the return table

## Step 2: Add new adapter methods

**File:** `infrastructure/adapters/chatbot.lua`

Add methods for commands not yet mapped:

- `send_prompt()` — runs `:ClaudeCodeSend`
- `add_file()` — runs `:ClaudeCodeAdd %`
- `select_model()` — runs `:ClaudeCodeSelectModel`
- `accept_diff()` — runs `:ClaudeCodeDiffAccept`
- `deny_diff()` — runs `:ClaudeCodeDiffDeny`

## Step 3: Add new use case methods

**File:** `application/use_cases/chatbot.lua`

Add methods (each returns a function):

- `send_prompt()` — delegates to `adapter.send_prompt()`
- `add_file()` — delegates to `adapter.add_file()`
- `select_model()` — delegates to `adapter.select_model()`
- `accept_diff()` — delegates to `adapter.accept_diff()`
- `deny_diff()` — delegates to `adapter.deny_diff()`

## Step 4: Rewrite chatbot keybinding map

**File:** `domain/maps/chatbot.lua`

Keep `<leader>$d` prefix. Update existing bindings and add new ones from Spacemacs:

| Key           | Description    | Method                             |
| ------------- | -------------- | ---------------------------------- |
| `<leader>$d`  | Claude Code    | _(group header)_                   |
| `<leader>$ds` | Start          | `session({ action = "start" })`    |
| `<leader>$dp` | Send prompt    | `send_prompt()`                    |
| `<leader>$dc` | Continue       | `session({ action = "continue" })` |
| `<leader>$dr` | Resume         | `session({ action = "resume" })`   |
| `<leader>$dl` | List sessions  | `session({ action = "list" })`     |
| `<leader>$db` | Switch buffer  | `session({ action = "buffer" })`   |
| `<leader>$dt` | Toggle window  | `session({ action = "toggle" })`   |
| `<leader>$dq` | Stop           | `session({ action = "stop" })`     |
| `<leader>$di` | Send selection | `edit()` (visual mode)             |
| `<leader>$dm` | Select model   | `select_model()`                   |
| `<leader>$da` | Accept diff    | `accept_diff()`                    |
| `<leader>$dx` | Deny diff      | `deny_diff()`                      |
| `<leader>$df` | Add file       | `add_file()`                       |

**OpenCode:** Keep under `<leader>$o` as-is.

## Step 5: No prefix change needed

The chatbot map already uses `<leader>$` prefix — keep it as-is. No changes to `domain/maps/init.lua` needed.

## Verification

1. Open Neovim — no startup errors
2. Press `<leader>$d` — see Claude Code submenu
3. `<leader>$ds` opens Claude Code terminal
4. `<leader>$dt` toggles the terminal
5. Visual select + `<leader>$di` sends selection
6. `<leader>$dm` opens model selector
7. `<leader>$da` / `<leader>$dx` accept/deny diffs
