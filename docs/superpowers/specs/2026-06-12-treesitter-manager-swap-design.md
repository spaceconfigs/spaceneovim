# Replace nvim-treesitter with tree-sitter-manager.nvim

**Date:** 2026-06-12
**Status:** Approved

## Goal

Replace the archived `nvim-treesitter/nvim-treesitter` plugin with
[`romus204/tree-sitter-manager.nvim`](https://github.com/romus204/tree-sitter-manager.nvim)
as the parser manager and highlighting provider, lazy-loaded through the
existing clean-architecture buffer hook.

## Environment requirements (verified locally)

- Neovim 0.12+ — have 0.12.2
- system `tree-sitter` CLI — have 0.26.9 at `/usr/bin/tree-sitter`
- C compiler — gcc 16.1.1

## Changes

### 1. Plugin specs — `lua/infrastructure/plugins/lazy/configs/init.lua`

- **Replace** the `nvim-treesitter/nvim-treesitter` spec with:

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
    },
  }
  ```

  (Amended post-review: no custom `languages` entry for angular —
  tree-sitter-manager ships a built-in angular repo pointing at the same
  `dlvandenberg/tree-sitter-angular` URL with a pinned revision and
  `html`/`html_tags` deps, so `auto_install` covers it.)

  `lazy = true` with no `event` trigger: the plugin loads when the buffer
  hook requires it (see Lazy-loading below).

- **Promote** `nvim-treesitter/nvim-treesitter-context` to a standalone
  top-level spec, keeping its existing `opts` function (transparent
  `TreesitterContext` highlight, `multiline_threshold = 1`). It runs on
  built-in `vim.treesitter` and only needs parsers installed.

- **Remove** `nvim-treesitter/nvim-treesitter-textobjects` (user decision:
  dropped, as it is the only companion with compatibility doubt).

- **Remove** the `dlvandenberg/tree-sitter-angular` dependency entry — the
  Angular parser is now installed by the manager via its `languages` table.

- **Delete** `"nvim-treesitter/nvim-treesitter"` from the `dependencies`
  of the 6 other specs: `render-markdown.nvim`, `nvim-dap-virtual-text`,
  `telescope-dap.nvim`, `orgmode`, `neotest`, `hurl.nvim`. Any remaining
  reference would make lazy.nvim reinstall it.

### 2. Plugin wrapper — `lua/infrastructure/plugins/treesitter.lua`

Switch `pcall(require, "nvim-treesitter")` to
`pcall(require, "tree-sitter-manager")` and update the error message.

### 3. Everything else — unchanged

The port (`application/ports/treesitter.lua`), adapter
(`infrastructure/adapters/treesitter.lua`), use case
(`application/usecases/treesitter.lua`), buffer hook, and all registry
entries keep the `treesitter` name. The feature is still "treesitter";
only the backing plugin changes.

## Lazy-loading mechanism

`infrastructure/events/buffer.lua` fires `on_buffer_init()` on
`BufRead`/`BufNewFile`. The hook calls `treesitter_usecase.setup()` →
adapter → `plugin_registry.treesitter()` → `require("tree-sitter-manager")`,
which lazy.nvim intercepts, loading the plugin and running `setup(opts)`.
Since `BufRead` (i.e. `BufReadPost`) fires **before** the same buffer's
`FileType` event, the manager's auto-install/highlight autocmds are
registered in time to catch even the first opened buffer.

## Out of scope

- Removing leftover nvim-treesitter parser artifacts from disk (harmless;
  the manager compiles fresh parsers into `stdpath("data")/site/parser`).
- `lazy-lock.json` updates happen via `:Lazy sync` on next launch.

## Verification

1. Headless smoke test: `nvim --headless` loads without errors;
   requiring `tree-sitter-manager` succeeds and `:TSManager` exists
   after a buffer is opened.
2. Open a `.lua` and a `.md` file; confirm treesitter highlighting is
   active (`vim.treesitter.highlighter.active`) and treesitter-context
   still works.
3. `grep` confirms no remaining `nvim-treesitter/nvim-treesitter`
   references in plugin specs.

## Rollback

Single-commit revert restores nvim-treesitter; old parsers remain on disk
under the lazy plugin path, so rollback is instant.
