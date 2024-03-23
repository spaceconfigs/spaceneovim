local ok, structlog = pcall(require, "structlog")
if not ok then
	return vim.notify("Failed to load plugin `Tastyep/structlog.nvim`")
end

structlog.configure({
	[""] = {
		pipelines = {
			{
				level = structlog.level.ERROR,
				processors = {
					structlog.processors.StackWriter({}, { max_parents = 0, stack_level = 0 }),
					structlog.processors.Timestamper("%H:%M:%S"),
				},
				formatter = structlog.formatters.FormatColorizer(
					"%s [%s] %s: %-30s",
					{ "timestamp", "level", "logger_name", "msg" },
					{ level = structlog.formatters.FormatColorizer.color_level() }
				),
				sink = structlog.sinks.Console(),
			},
			{
				level = structlog.level.WARN,
				processors = {
					structlog.processors.StackWriter({}, { max_parents = 0, stack_level = 0 }),
					structlog.processors.Timestamper("%H:%M:%S"),
				},
				formatter = structlog.formatters.FormatColorizer(
					"%s [%s] %s: %-30s",
					{ "timestamp", "level", "logger_name", "msg" },
					{ level = structlog.formatters.FormatColorizer.color_level() }
				),
				sink = structlog.sinks.Console(),
			},
			{
				level = structlog.level.INFO,
				processors = {
					structlog.processors.StackWriter({}, { max_parents = 0, stack_level = 0 }),
					structlog.processors.Timestamper("%H:%M:%S"),
				},
				formatter = structlog.formatters.FormatColorizer(
					"%s [%s] %s: %-30s",
					{ "timestamp", "level", "logger_name", "msg" },
					{ level = structlog.formatters.FormatColorizer.color_level() }
				),
				sink = structlog.sinks.Console(),
			},
			{
				level = structlog.level.DEBUG,
				processors = {
					structlog.processors.StackWriter({}, { max_parents = 0, stack_level = 0 }),
					structlog.processors.Timestamper("%H:%M:%S"),
				},
				formatter = structlog.formatters.FormatColorizer(
					"%s [%s] %s: %-30s",
					{ "timestamp", "level", "logger_name", "msg" },
					{ level = structlog.formatters.FormatColorizer.color_level() }
				),
				sink = structlog.sinks.Console(),
			},
			{
				level = structlog.level.TRACE,
				processors = {
					structlog.processors.StackWriter({}, { max_parents = 3 }),
					structlog.processors.Timestamper("%H:%M:%S"),
				},
				formatter = structlog.formatters.Format( --
					"%s [%s] %s: %-30s",
					{ "timestamp", "level", "logger_name", "msg" }
				),
				sink = structlog.sinks.File(vim.fn.getenv("NVIM_LOG_FILE")),
			},
		},
	},
})

local logger = structlog.get_logger("")
logger.level = require("structlog.level")
return logger
