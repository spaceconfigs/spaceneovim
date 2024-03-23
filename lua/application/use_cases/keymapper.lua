local M = {}

local maps = require("domain.maps")
local adapter = require("infraestrucuture.adapters.keymapper")

for _, map in pairs(maps) do
	if map.key ~= nil then
		adapter.regist(map)
		goto continue
	end

	for _, bind in pairs(map) do
		adapter.regist(bind)
	end

	::continue::
end

return M
