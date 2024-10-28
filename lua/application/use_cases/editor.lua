local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infrastructure.adapters.editor")
end

M.drag_down = function(opts)
	return function()
		local message = {
			module = "use_cases/editor",
			func = "drag_down",
			opts = opts,
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.drag_down(opts)
	end
end

M.drag_up = function(opts)
	return function()
		local message = {
			module = "use_cases/editor",
			func = "drag_up",
			opts = opts,
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.drag_up(opts)
	end
end

M.next_paragraph = function()
	return function()
		local message = {
			module = "use_cases/editor",
			func = "next_paragraph",
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.next_paragraph()
	end
end

M.previous_paragraph = function()
	return function()
		local message = {
			module = "use_cases/editor",
			func = "previous_paragraph",
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.previous_paragraph()
	end
end

M.paste_before = function()
	return function()
		local message = {
			module = "use_cases/editor",
			func = "paste_before",
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.paste_before()
	end
end

M.paste_after = function()
	return function()
		local message = {
			module = "use_cases/editor",
			func = "paste_after",
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.paste_after()
	end
end

M.delete_word = function()
	return function()
		local message = {
			module = "use_cases/editor",
			func = "delete_word",
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.delete_word()
	end
end

M.terminal_escape = function()
	return function()
		local message = {
			module = "use_cases/editor",
			func = "terminal_escape",
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.terminal_escape()
	end
end

M.noop = function()
	return function()
		local message = {
			module = "use_cases/editor",
			func = "noop",
		}
		logger_use_case.debug(message)
		local adapter = M.setup()

		adapter.noop()
	end
end

return M
