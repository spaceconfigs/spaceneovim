# Plan: Normalize map methods to always return a function

## Context

Per `specs/normalize-map-methods.md`, every `method` in `lua/domain/maps/*.lua` must be a use case function call that **returns a function**. Currently 47 entries use raw strings, `vim.*` refs, inline functions, or bare references. This plan details the implementation steps.

## Summary: 47 non-conforming entries across 8 map files

| Category                          | Count | Map files                                      |
| --------------------------------- | ----- | ---------------------------------------------- |
| Raw vim ex-commands               | 27    | quit, window, toggler, unprefixed, file, major |
| Direct `vim.*` references         | 4     | major                                          |
| Bare use case refs (missing `()`) | 3     | jump                                           |
| Inline anonymous functions        | 2     | project, unprefixed                            |

---

## Step 1: Fix bare use case references in `jump.lua`

**No new files needed.** These use case methods exist but are referenced without `()`. However, the underlying methods (`timer`, `words`, `lines`) do NOT return functions — they execute directly. Each must be refactored to return a function.

| File                   | Line | Current                 | Target                    |
| ---------------------- | ---- | ----------------------- | ------------------------- |
| `domain/maps/jump.lua` | 4    | `jumper_use_case.timer` | `jumper_use_case.timer()` |
| `domain/maps/jump.lua` | 5    | `jumper_use_case.words` | `jumper_use_case.words()` |
| `domain/maps/jump.lua` | 6    | `jumper_use_case.lines` | `jumper_use_case.lines()` |

**Also modify:**

- `application/use_cases/jumper.lua` — wrap `timer`, `words`, `lines` to return a function
- `infrastructure/adapters/jumper.lua` — ensure adapter methods support the return-a-function pattern

## Step 2: Add methods to existing `window` use case

**Existing file:** `application/use_cases/window.lua` (has move/resize/go methods but no close/split/vsplit)

Add methods that return functions:

- `close()` — wraps `:quit<cr>`
- `split()` — wraps `:split<cr>`
- `vsplit()` — wraps `:vsplit<cr>`
- `split_previous()` — wraps `:split | wincmd p<cr>`
- `vsplit_previous()` — wraps `:vsplit | wincmd p<cr>`

**Also modify:** `infrastructure/adapters/window.lua` — add corresponding adapter methods

**Update map:** `domain/maps/window.lua` lines 19, 29, 30, 32, 33

## Step 3: Create `quit` use case (new)

**New files:**

- `application/use_cases/quit.lua`
- `infrastructure/adapters/quit.lua`

Methods (each returns a function):

- `all()` — wraps `:confirm qall<cr>`
- `save_all()` — wraps `:wqall<cr>`

**Update map:** `domain/maps/quit.lua` lines 2, 3

## Step 4: Add methods to existing `file` use case

**Existing file:** `application/use_cases/file.lua` (has list/search/rename/copy but no config/delete/save)

Add methods that return functions:

- `edit_config()` — wraps `<cmd>edit $MYVIMRC<cr>`
- `source_config()` — wraps `<cmd>source $MYVIMRC<cr>`
- `delete_current()` — wraps `<cmd>call delete(expand('%')) | bdelete!<cr>`
- `save()` — wraps `<cmd>write!<cr>`
- `save_all()` — wraps `<cmd>wall!<cr>`

**Also modify:** `infrastructure/adapters/file.lua`

**Update map:** `domain/maps/file.lua` lines 15, 16, 45, 49, 50

## Step 5: Add methods to existing `toggler` use case or create new one

**Check if `application/use_cases/toggler.lua` exists.** Currently no toggler use case.

**New files:**

- `application/use_cases/toggler.lua`
- `infrastructure/adapters/toggler.lua`

Methods (each returns a function):

- `number()` — wraps `:set number<cr>`
- `wrap()` — wraps `:set wrap!<cr>`

**Update map:** `domain/maps/toggler.lua` lines 13, 17

## Step 6: Add methods to existing `lsp` use case

**Existing file:** `application/use_cases/lsp.lua` (has definition/references/format but missing some)

Add methods that return functions:

- `rename()` — wraps `vim.lsp.buf.rename`
- `signature_help()` — wraps `vim.lsp.buf.signature_help`
- `code_action()` — wraps `vim.lsp.buf.code_action`

**Update map:** `domain/maps/major.lua` lines 66, 107, 118

## Step 7: Add `setloclist` to existing `diagnostic` use case

**Existing file:** `application/use_cases/diagnostic.lua` (has toggle/show)

Add method:

- `loclist()` — wraps `vim.diagnostic.setloclist`, returns a function

**Also modify:** `infrastructure/adapters/diagnostic.lua`

**Update map:** `domain/maps/major.lua` line 108

## Step 8: Handle `unprefixed.lua` — movement and terminal operations

Most complex file. Group into use cases:

### 8a: Add to existing `terminal` use case

- `escape()` — wraps `<C-\><C-n>` (terminal normal mode)

**Update map:** `domain/maps/unprefixed.lua` line 47

### 8b: Create `editor` use case (new)

For general editing operations with no existing home:

**New files:**

- `application/use_cases/editor.lua`
- `infrastructure/adapters/editor.lua`

Methods (each returns a function):

- `drag_down(opts)` — line drag, opts `{ mode = "normal"|"visual"|"insert" }`
- `drag_up(opts)` — line drag, opts `{ mode = "normal"|"visual"|"insert" }`
- `next_paragraph()` — wraps `}`
- `previous_paragraph()` — wraps `{`
- `paste_before()` — wraps `P`
- `paste_after()` — wraps `p`
- `delete_word()` — wraps `<C-w>`
- `noop()` — wraps `function() end`

**Update map:** `domain/maps/unprefixed.lua` lines 13-18, 23, 29, 35, 41, 49, 50, 57

## Step 9: Handle search commands in `major.lua`

Add to existing `searcher` use case or `lsp` use case:

- `search_link_next()` — wraps `/https\\?=\\?<CR>`
- `search_link_previous()` — wraps `?https\\?=\\?<CR>`

**Update map:** `domain/maps/major.lua` lines 119, 120

## Step 10: Fix inline function in `project.lua`

Add composite method to `workspace` use case:

- `add_and_toggle_tree()` — wraps `workspace_use_case.add(); tree_use_case.toggle()()`

**Update map:** `domain/maps/project.lua` lines 18-21

---

## New files to create

| File                                  | Purpose                                      |
| ------------------------------------- | -------------------------------------------- |
| `application/use_cases/quit.lua`      | Quit operations                              |
| `infrastructure/adapters/quit.lua`    | Quit adapter                                 |
| `application/use_cases/toggler.lua`   | Toggle vim options                           |
| `infrastructure/adapters/toggler.lua` | Toggler adapter                              |
| `application/use_cases/editor.lua`    | General editing (drag, paste, paragraph nav) |
| `infrastructure/adapters/editor.lua`  | Editor adapter                               |

## Existing files to modify

| File                                     | Changes                                        |
| ---------------------------------------- | ---------------------------------------------- |
| `application/use_cases/window.lua`       | Add close, split, vsplit methods               |
| `infrastructure/adapters/window.lua`     | Add corresponding adapter methods              |
| `application/use_cases/file.lua`         | Add config/delete/save methods                 |
| `infrastructure/adapters/file.lua`       | Add corresponding adapter methods              |
| `application/use_cases/lsp.lua`          | Add rename, signature_help, code_action        |
| `infrastructure/adapters/lsp.lua`        | Add corresponding adapter methods              |
| `application/use_cases/diagnostic.lua`   | Add loclist method                             |
| `infrastructure/adapters/diagnostic.lua` | Add corresponding adapter method               |
| `application/use_cases/terminal.lua`     | Add escape method                              |
| `infrastructure/adapters/terminal.lua`   | Add corresponding adapter method               |
| `application/use_cases/jumper.lua`       | Refactor timer/words/lines to return functions |
| `infrastructure/adapters/jumper.lua`     | Support return-a-function pattern              |
| `application/use_cases/searcher.lua`     | Add link search methods                        |
| `infrastructure/adapters/searcher.lua`   | Add corresponding adapter methods              |
| `application/use_cases/workspace.lua`    | Add composite add_and_toggle_tree              |
| `domain/maps/jump.lua`                   | Add `()` to 3 method refs                      |
| `domain/maps/window.lua`                 | Replace 5 raw strings                          |
| `domain/maps/quit.lua`                   | Replace 2 raw strings                          |
| `domain/maps/file.lua`                   | Replace 5 raw strings                          |
| `domain/maps/toggler.lua`                | Replace 2 raw strings                          |
| `domain/maps/major.lua`                  | Replace 4 vim.\* refs + 2 raw strings          |
| `domain/maps/unprefixed.lua`             | Replace ~14 raw strings + 1 inline fn          |
| `domain/maps/project.lua`                | Replace 1 inline function                      |

## Verification

1. `grep` all map files — no raw strings, no `vim.*` refs, no `function()` inline
2. Every `method` is a use case call with `()`
3. Open Neovim — no startup errors
4. `:checkhealth` passes
5. Test keybindings: quit, window split, file save, LSP rename, line drag, jump
