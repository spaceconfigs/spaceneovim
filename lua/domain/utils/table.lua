local M = {}

--- Deep-copy a value (tables copied recursively, other types returned as-is).
--- Pure Lua — replaces `vim.deepcopy` so the domain has no framework dependency.
--- The keybinding tables it clones are plain data (no metatables/cycles).
---@generic T
---@param value T
---@return T
local function clone(value)
	if type(value) ~= "table" then
		return value
	end

	local out = {}
	for k, v in pairs(value) do
		out[k] = clone(v)
	end
	return out
end

M.clone = clone

return M
