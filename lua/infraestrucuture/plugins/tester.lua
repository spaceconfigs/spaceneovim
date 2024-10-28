local neotest_ok, neotest = pcall(require, "neotest")
if not neotest_ok then
	return vim.notify("Failed to load plugin `nvim-neotest/neotest")
end

local jest_adapter = require("neotest-jest")({
	jestCommand = "npm run test --",
	jestConfigFile = "custom.jest.config.ts",
	env = { CI = true },
	cwd = function()
		return vim.fn.getcwd()
	end,
})

local java_adapter = require("neotest-java")({
	ignore_wrapper = false,
	junit_jar = nil,
})

neotest.setup({
	adapters = { jest_adapter, java_adapter },
})

return {
	neotest = neotest,
}
