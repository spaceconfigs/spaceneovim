# Plan: Rename `infraestrucuture` → `infrastructure`

## Context

The directory `lua/infraestrucuture/` has a typo preserved since the project's creation. Per spec (`specs/fix-infrastructure-directory-name.md`), this rename touches ~96 Lua files and 2 docs. The goal is to fix the spelling without breaking any module loading.

## Steps

### Step 1: Rename the directory
```bash
mv lua/infraestrucuture lua/infrastructure
```

### Step 2: Global find-and-replace in Lua files
Replace all `infraestrucuture` → `infrastructure` in require strings across:
- `init.lua` (1 occurrence)
- `lua/application/use_cases/*.lua` (43 files, 1 occurrence each)
- `lua/infrastructure/**/*.lua` (~50 files with internal cross-references)

### Step 3: Update documentation
- `CLAUDE.md` — replace 8 occurrences, remove the "typo preserved for compatibility" note
- `README.md` — replace 1 occurrence in directory tree

### Step 4: Verify
1. `grep -r "infraestrucuture" .` returns no results (excluding `.git/`)
2. Open Neovim — confirm startup with no errors
3. `:checkhealth` passes
4. Test a few keybindings to confirm use cases load correctly
