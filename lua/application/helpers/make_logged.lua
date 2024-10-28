local logger_use_case = require("application.use_cases.logger")

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
