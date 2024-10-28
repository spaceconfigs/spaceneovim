# Spec: Fix `infraestrucuture` directory name typo

## Problem

The directory `lua/infraestrucuture/` is misspelled. The correct spelling is `infrastructure`.

## Solution

Rename `lua/infraestrucuture/` → `lua/infrastructure/` and update all references.

## Scope

### 1. Directory rename

```
lua/infraestrucuture/ → lua/infrastructure/
```

Contains ~97 files across subdirectories: `adapters/`, `events/`, `plugins/`, `utils/`.

### 2. Root bootstrap

| File | Occurrences |
|------|-------------|
| `init.lua` | 1 |

### 3. Application use cases (require statements)

All 43 files in `lua/application/use_cases/` contain a `require("infraestrucuture.adapters.<name>")` that must be updated.

### 4. Internal cross-references

~50 files inside `lua/infraestrucuture/` itself reference sibling modules via `require("infraestrucuture....")`. These paths update automatically with the directory rename only if the require strings are also changed.

### 5. Documentation

| File | Occurrences |
|------|-------------|
| `CLAUDE.md` | 8 |
| `README.md` | 1 |

## Total

- **1** directory rename
- **~96** Lua files with require path updates
- **2** documentation files with text updates

## Verification

1. Rename directory: `mv lua/infraestrucuture lua/infrastructure`
2. Find-and-replace `infraestrucuture` → `infrastructure` across all files
3. Open Neovim and confirm it starts without errors
4. Run `:checkhealth` to verify plugin loading
5. Confirm `grep -r "infraestrucuture" lua/` returns no results
