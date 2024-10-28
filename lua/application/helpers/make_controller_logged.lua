local logger_use_case = require("application.use_cases.logger")

---Wraps a controller module so every method logs when its key is pressed.
---Returns a proxy with the same shape as `module`, so callers keep full types.
---@generic T
---@param module_name string
---@param module T
---@return T
return function(module_name, module)
  return setmetatable({}, {
    __index = function(_, func_name)
      local original = module[func_name]

      if type(original) ~= "function" then
        return original
      end

      return function(...)
        local args = { ... }
        local closure = original(...)

        if type(closure) ~= "function" then
          return closure
        end

        return function()
          logger_use_case.debug({
            module = "controllers/" .. module_name,
            func = func_name,
            args = args,
          })
          return closure()
        end
      end
    end,
  })
end
