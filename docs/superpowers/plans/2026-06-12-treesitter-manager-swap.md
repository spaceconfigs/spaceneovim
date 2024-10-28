# Replace nvim-treesitter with tree-sitter-manager.nvim — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Swap the archived `nvim-treesitter/nvim-treesitter` plugin for `romus204/tree-sitter-manager.nvim` as parser manager + highlighter, lazy-loaded through the existing buffer hook.

**Architecture:** SpaceNeoVim's Clean Architecture isolates the plugin behind `lua/infrastructure/plugins/treesitter.lua`; only that wrapper and the lazy.nvim specs change. The buffer hook (`on_buffer_init`, fired on `BufRead`/`BufNewFile`) already `require`s the plugin via the registry chain, which lazy.nvim intercepts to load + `setup()` the manager before the buffer's `FileType` event fires.

**Tech Stack:** Neovim 0.12.2, lazy.nvim, tree-sitter CLI 0.26.9 (system). No test framework in this repo — verification is grep + headless `nvim` smoke tests.

**Spec:** `docs/superpowers/specs/2026-06-12-treesitter-manager-swap-design.md`

**Pre-existing working-tree note:** `lua/infrastructure/plugins/lazy/configs/init.lua` has one uncommitted line (`lazy = false,` on the nvim-treesitter spec) — it is inside the block Task 1 replaces, so it is subsumed. Do NOT `git add` the other modified files (`lua/application/ports/editor.lua`, `lua/application/usecases/editor.lua`, `lua/infrastructure/adapters/editor.lua`, `lua/presentation/hooks/buffer.lua`) — they are unrelated pending work. Always `git add` specific paths, never `-A`/`.`.

---

### Task 1: Swap the main plugin spec

**Files:**
- Modify: `lua/infrastructure/plugins/lazy/configs/init.lua:27-55`

- [ ] **Step 1: Replace the nvim-treesitter spec block**

In `lua/infrastructure/plugins/lazy/configs/init.lua`, replace this entire block (starts at line 27; includes the uncommitted `lazy = false,` line):

```lua
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-context",
        opts = function()
          vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "none" })
          return {
            multiline_threshold = 1,
          }
        end,
      },
      { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
      "dlvandenberg/tree-sitter-angular",
    },
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "markdown",
        "html",
        "markdown_inline",
      },
      auto_install = true,
    },
  },
```

with:

```lua
  {
    "romus204/tree-sitter-manager.nvim",
    lazy = true,
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "markdown",
        "html",
        "markdown_inline",
      },
      auto_install = true,
      languages = {
        angular = {
          install_info = {
            url = "https://github.com/dlvandenberg/tree-sitter-angular",
            use_repo_queries = true,
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = function()
      vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "none" })
      return {
        multiline_threshold = 1,
      }
    end,
  },
```

Notes:
- `lazy = true` with no `event`: the plugin loads when the buffer hook's registry chain `require`s `"tree-sitter-manager"`. lazy.nvim calls `setup(opts)` at that moment.
- treesitter-context becomes a standalone spec with no lazy trigger (loads at startup, same as before when it was a dependency of a `lazy = false` plugin).
- textobjects is dropped per the spec; the Angular parser moves into the manager's `languages` table.

- [ ] **Step 2: Verify the file still parses**

Run: `luajit -bl lua/infrastructure/plugins/lazy/configs/init.lua > /dev/null 2>&1 || nvim --headless --clean +'luafile lua/infrastructure/plugins/lazy/configs/init.lua' +qa`
Expected: no output / exit 0 (no Lua syntax errors)

- [ ] **Step 3: Commit**

```bash
git add lua/infrastructure/plugins/lazy/configs/init.lua
git commit -m "feat: replace nvim-treesitter spec with tree-sitter-manager.nvim"
```

---

### Task 2: Remove nvim-treesitter from the 6 dependent specs

**Files:**
- Modify: `lua/infrastructure/plugins/lazy/configs/init.lua` (6 locations; line numbers shift after Task 1 — locate by plugin name)

Any remaining `"nvim-treesitter/nvim-treesitter"` in a `dependencies` list makes lazy.nvim reinstall it.

- [ ] **Step 1: render-markdown.nvim — remove the treesitter dependency line**

Change:

```lua
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.nvim",
      "HakonHarnes/img-clip.nvim",
    },
```

to:

```lua
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "echasnovski/mini.nvim",
      "HakonHarnes/img-clip.nvim",
    },
```

- [ ] **Step 2: nvim-dap-virtual-text — remove the treesitter dependency line**

Change:

```lua
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-treesitter/nvim-treesitter",
    },
  },
```

to:

```lua
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
```

- [ ] **Step 3: telescope-dap.nvim — remove the treesitter dependency line**

Change:

```lua
  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
```

to:

```lua
  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-telescope/telescope.nvim",
    },
  },
```

- [ ] **Step 4: orgmode — remove the now-empty dependencies table**

Change:

```lua
  {
    "nvim-orgmode/orgmode",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
    },
    opts = {},
  },
```

to:

```lua
  {
    "nvim-orgmode/orgmode",
    opts = {},
  },
```

- [ ] **Step 5: neotest — remove the treesitter dependency line**

Change:

```lua
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-jest",
    },
  },
```

to:

```lua
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-neotest/neotest-jest",
    },
  },
```

- [ ] **Step 6: hurl.nvim — remove the treesitter dependency line**

Change:

```lua
  {
    "jellydn/hurl.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
      },
    },
```

to:

```lua
  {
    "jellydn/hurl.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
      },
    },
```

- [ ] **Step 7: Verify no references remain**

Run: `grep -n 'nvim-treesitter/nvim-treesitter"' lua/infrastructure/plugins/lazy/configs/init.lua`
Expected: no output (the only remaining `nvim-treesitter/...` string is `nvim-treesitter-context`, which this grep's closing quote excludes)

Run: `grep -n 'nvim-treesitter' lua/infrastructure/plugins/lazy/configs/init.lua`
Expected: exactly one line — the `nvim-treesitter/nvim-treesitter-context` spec

- [ ] **Step 8: Commit**

```bash
git add lua/infrastructure/plugins/lazy/configs/init.lua
git commit -m "refactor: drop nvim-treesitter from dependent plugin specs"
```

---

### Task 3: Point the plugin wrapper at tree-sitter-manager

**Files:**
- Modify: `lua/infrastructure/plugins/treesitter.lua`

- [ ] **Step 1: Replace the wrapper contents** (file uses tabs for indentation):

```lua
local ok, plugin = pcall(require, "tree-sitter-manager")
if not ok then
	error("Failed to load plugin `romus204/tree-sitter-manager.nvim`")
end

return plugin
```

- [ ] **Step 2: Commit**

```bash
git add lua/infrastructure/plugins/treesitter.lua
git commit -m "refactor: treesitter plugin wrapper requires tree-sitter-manager"
```

---

### Task 4: Sync plugins and smoke-test

**Files:**
- Modify (generated): `lazy-lock.json`

- [ ] **Step 1: Sync plugins headlessly** (installs tree-sitter-manager, removes nvim-treesitter/textobjects/angular, updates the lock file)

Run: `nvim --headless "+Lazy! sync" +qa`
Expected: exits 0. (Parser compilation by the manager may also kick off; that's fine.)

- [ ] **Step 2: Smoke-test plugin load via the buffer hook path**

Run:

```bash
nvim --headless +'edit lua/init.lua' +'lua vim.wait(3000)' \
  +'lua local ok = pcall(require, "tree-sitter-manager"); print("manager loaded: " .. tostring(ok))' \
  +'lua print("TSManager cmd: " .. tostring(vim.fn.exists(":TSManager") == 2))' \
  +qa 2>&1
```

Expected output contains: `manager loaded: true` and `TSManager cmd: true`. If `ensure_installed` parsers are still compiling, rerun once after it finishes.

- [ ] **Step 3: Verify highlighting on a real buffer**

Run:

```bash
nvim --headless +'edit lua/init.lua' +'lua vim.wait(3000)' \
  +'lua print("highlighter active: " .. tostring(vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] ~= nil))' \
  +qa 2>&1
```

Expected output contains: `highlighter active: true`. (If false on first run, parsers were still compiling — rerun.)

- [ ] **Step 4: Confirm nvim-treesitter is gone from the lock file**

Run: `grep -n '"nvim-treesitter"\|textobjects\|tree-sitter-angular' lazy-lock.json`
Expected: no output. And `grep -n 'tree-sitter-manager' lazy-lock.json` shows one entry.

- [ ] **Step 5: Commit the lock file**

```bash
git add lazy-lock.json
git commit -m "chore: sync lazy-lock for tree-sitter-manager swap"
```
