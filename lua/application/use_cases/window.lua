local vim = vim
local M = {}

local logger_use_case = require("application.use_cases.logger")

M.setup = function()
	return require("infraestrucuture.adapters.window")
end

M.toggle = function()
	local message = {
		module = "use_cases/window",
		func = "toggle",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.toggle()
end

M.shrink_height = function()
	local message = {
		module = "use_cases/window",
		func = "shrink_height",
	}
	logger_use_case.debug(message)

	vim.api.nvim_win_set_height(0, vim.api.nvim_win_get_height(0) + 5)
end

M.expand_height = function()
	local message = {
		module = "use_cases/window",
		func = "shrink_height",
	}
	logger_use_case.debug(message)

	vim.api.nvim_win_set_height(0, vim.api.nvim_win_get_height(0) - 5)
end

M.shrink_width = function()
	local message = {
		module = "use_cases/window",
		func = "shrink_height",
	}
	logger_use_case.debug(message)

	vim.api.nvim_win_set_width(0, vim.api.nvim_win_get_width(0) + 5)
end

M.expand_width = function()
	local message = {
		module = "use_cases/window",
		func = "expand_width",
	}
	logger_use_case.debug(message)

	vim.api.nvim_win_set_width(0, vim.api.nvim_win_get_width(0) - 5)
end

M.balance_area = function()
	local message = {
		module = "use_cases/window",
		func = "balance_area",
	}
	logger_use_case.debug(message)

	vim.cmd("wincmd =")
end

M.move_far_up = function()
	local message = {
		module = "use_cases/window",
		func = "move_far_up",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.move_far_up()
end

M.move_far_down = function()
	local message = {
		module = "use_cases/window",
		func = "move_far_down",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.move_far_down()
end

M.move_far_left = function()
	local message = {
		module = "use_cases/window",
		func = "move_far_left",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.move_far_left()
end

M.move_far_right = function()
	local message = {
		module = "use_cases/window",
		func = "move_far_right",
	}
	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.move_far_right()
end

M.go_left = function()
	local message = {
		module = "use_cases/window",
		func = "go_left",
	}

	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.go_left()
end

M.go_right = function()
	local message = {
		module = "use_cases/window",
		func = "go_right",
	}

	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.go_right()
end

M.go_up = function()
	local message = {
		module = "use_cases/window",
		func = "go_left",
	}

	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.go_up()
end

M.go_down = function()
	local message = {
		module = "use_cases/window",
		func = "go_down",
	}

	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.go_down()
end

M.move_left = function()
	local message = {
		module = "use_cases/window",
		func = "move_left",
	}

	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.move_left()
end

M.move_right = function()
	local message = {
		module = "use_cases/window",
		func = "move_right",
	}

	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.move_right()
end

M.move_up = function()
	local message = {
		module = "use_cases/window",
		func = "move_up",
	}

	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.move_up()
end

M.move_down = function()
	local message = {
		module = "use_cases/window",
		func = "move_down",
	}

	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.move_down()
end

M.dedicate = function()
	local message = {
		module = "use_cases/window",
		func = "dedicate",
	}

	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.dedicate()
end

M.center = function()
	local message = {
		module = "use_cases/window",
		func = "center",
	}

	logger_use_case.debug(message)
	local adapter = M.setup()

	adapter.center()
end
return M
