local keymapper = require("domain.contracts.controller_registry").keymapper()

local M = {}

--- Prefix the per-filetype menus are rooted at. Reserved: never typed directly.
M.root = "<F13>"

--- The bind that replaces the global `<leader>` menu inside a filetype buffer.
--- Returns a fresh table each call; callers add the buffer-local fields.
---@return KeyBind
M.redirect = function()
  return {
    key = "<leader>",
    description = "Filetype menu",
    method = keymapper.open({ keys = M.root }),
    mode = "n",
    nowait = true,
  }
end

--- Filetypes whose `<leader>` menu fully replaces the global one.
---
--- Empty by design: no filetype overrides the global menu today. To add one,
--- drop a `lua/domain/maps/filetypes/<name>.lua` returning a `fun(): KeyBind[]`
--- of unprefixed binds (a bind with no `method` is a group label), then map it
--- here under every filetype that should show it:
---
---   local menu = require("domain.maps.filetypes.<name>")
---   M.menus = { SomeFiletype = menu, SomeOtherFiletype = menu }
---
--- `application.usecases.keymapper.register_filetype` does the rest: it prefixes
--- the binds with `M.root` and registers them buffer-locally alongside the
--- redirect whenever a buffer of that filetype opens. Transient single-key UIs
--- (e.g. `NeogitPopup`) and ordinary editable buffers (e.g. `gitcommit`) are
--- poor candidates: they either own their keys already or want the global menu.
---@type table<string, fun(): KeyBind[]>
M.menus = {}

return M
