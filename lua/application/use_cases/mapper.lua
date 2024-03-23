local M = {}

M.setup = function(adapter)
    if not adapter then
        return
    end

    M.interface = adapter;
end

return M
