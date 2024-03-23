local M = {}

local maps = require("domain.maps")
local adapter = require("infraestrucuture.adapters.keymapper")

adapter.regist_all(maps)

return M
