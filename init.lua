-- TODO: change calls from modole functions in `which-key` for interfaces (strings)
-- TODO: Configure workspace to not change directory on buffer ediction
-- TODO: Change all debug log call to trace level
-- TODO: Create a log file on vim cache folder on bootstrep
-- TODO: Log all trace on the log file
-- TODO: Create bind files on domain layer
-- TODO: Set on `keymapper` binds make on domain layer
-- TODO: Set `,` key as a short version of `major` mode
-- TODO: Configure `config` lazy folder just with module file
-- TODO: Configure the bind <Super-m-i-H> to insert header apropertly in each kind of file (org or markdown)
-- TODO: change from `vim.notify` in each `plugin` file to `logger_use_case.error`
-- TODO: look for how check performance on bootstrap of neovim. Spended time to start it
-- TODO: restart neovim with all changeds on children modules
-- FIX: connection with js-debugger-dap with node version `v14.15.0`

local environment = require("domain.environments").PRODUCTION
vim.fn.setenv("NVIM_ENVIRONMENT", environment)

require("config")
require("application.use_cases")
require("application.events")

local logger_use_case = require("application.use_cases.logger")
-- logger_use_case.info("NVIM_ENVIRONMENT=" .. environment)
