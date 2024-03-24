local M = {}

local maps = require("domain.maps")
local adapter = require("infraestrucuture.adapters.keymapper")

adapter.regist_all(maps)

M.format = function(opts)
	local map = adapter.format(opts)
	return map
end

M.regist = function(map)
	adapter.regist(map)
end

return M
