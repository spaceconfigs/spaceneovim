---@meta
--- Shared type definitions for SpaceNeoVim's Clean Architecture layers.
--- This file is never `require`d at runtime; lua_ls/lazydev read it to type-check
--- and autocomplete the project. See CLAUDE.md for the layer descriptions.

---A closure executed on keypress. Controllers return one of these per method.
---@alias ControllerAction fun(): nil

---A controller method: accepts optional params at map-definition time and
---returns the `ControllerAction` closure run when the key is pressed.
---e.g. `M.go_to = function(opts) return function() ... end end`
---@alias ControllerFactory fun(opts?: table): ControllerAction

---Log severity levels. Values come from `domain/log_levels.lua`.
---@alias LogLevel "info"|"debug"|"warn"|"error"

---Config for a transient (Hydra) keymap state, built by the keymapper use case.
---@class TransientConfig
---@field hint? string             Multiline hint shown while the state is active
---@field color? string            Hydra color, e.g. "red" or "pink"; defaults to "pink"
---@field mode? string|string[]    Vim mode(s); defaults to "n"
---@field heads? table[]           Head tuples in the form { key, fn|nil, opts }

---A declarative keybinding entry as defined in `domain/maps/*.lua`.
---Registered with which-key by the keymapper use case.
---@class KeyBind
---@field key string                The key sequence, e.g. "<leader>bb"
---@field description string         which-key description shown in the popup
---@field method? ControllerAction   Closure run on keypress; omit for group/prefix labels
---@field mode? string|string[]      Vim mode(s); defaults to "n"
---@field buffer? integer            Buffer-local mapping; nil = global
---@field silent? boolean
---@field noremap? boolean
---@field nowait? boolean
---@field hidden? boolean            Hide the mapping/group from the which-key popup
