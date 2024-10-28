local logger_use_case = require("application.use_cases.logger")

---Wraps a use-case module so every method logs on invocation.
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
				logger_use_case.debug({
					module = "use_cases/" .. module_name,
					func = func_name,
					args = { ... },
				})
				return original(...)
			end
		end,
	})
end
