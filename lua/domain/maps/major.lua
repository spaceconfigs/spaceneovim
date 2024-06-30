local vim = vim
local lsp_use_case = require("application.use_cases.lsp")
local buffer_use_case = require("application.use_cases.buffer")
local rest_use_case = require("application.use_cases.rest")
local noter_use_case = require("application.use_cases.noter")
local formatter_use_case = require("application.use_cases.formatter")
local database_use_case = require("application.use_cases.database")

local format_content = {
	{ key = "=", description = "Format" },
	{ key = "==", description = "Format", method = formatter_use_case.format },
	{
		key = "=o",
		description = "Format",
		method = function()
			vim.lsp.buf.execute_command({ command = "_typescript.organizeImports", arguments = { vim.fn.expand("%p") } })
		end,
	},
	-- 	=o = {
	-- 		"<cmd>lua <cr>",
	-- 		"",
	-- 	},
}

local database_content = {
	{ key = "b", description = "database" },
	{ key = "bc", description = "Open", method = database_use_case.open },
}

local goto_content = {
	{ key = "g", description = "Goto" },
	{ key = "gd", description = "Definition", method = lsp_use_case.go_definition },
	{ key = "gi", description = "Implementation", method = lsp_use_case.go_implementation },
	{ key = "gk", description = "Documentation", method = lsp_use_case.show_documentation },
	{ key = "gK", description = "Signature", method = lsp_use_case.show_signature },
	{ key = "gr", description = "References", method = lsp_use_case.go_references },
	{ key = "gt", description = "Type-definition", method = lsp_use_case.go_typedefinition },
}

local help_content = {
	{ key = "h", description = "Help" },
	{ key = "hh", description = "Show hover", method = vim.lsp.buf.hover },
	{ key = "hH", description = "show signature help", method = vim.lsp.buf.signature_help },
}

local insert_content = {
	{ key = "i", description = "Insert" },
	{ key = "iH", description = "Heading", method = noter_use_case.insert_heading },
}

local refact_content = {
	{ key = "r", description = "Refact" },
	{ key = "rr", description = "Rename", method = vim.lsp.buf.rename },
	{ key = "rq", description = "Quickfix", method = vim.diagnostic.setloclist },
}

local toggle_content = {
	{ key = "T", description = "Toggle" },
	{ key = "Tc", description = "Toggle checkbox", method = noter_use_case.toggle_checkbox },
	{ key = "TT", description = "Cycle state", method = noter_use_case.todo_next_state },
}

local major_content = {
	{ key = "a", description = "Code Action", method = vim.lsp.buf.code_action },
	{ key = "s", description = "Rest", method = rest_use_case.send },
	{ key = "N", description = "Previous link", method = "/https\\?=\\?<CR>" },
	{ key = "P", description = "Next link", method = "?https\\?=\\?<CR>" },
}

local result = {}
local contents = {}
for _, content in pairs({
	format_content,
	database_content,
	goto_content,
	help_content,
	insert_content,
	refact_content,
	toggle_content,
	major_content,
}) do
	for _, bind in pairs(content) do
		table.insert(contents, bind)
	end
end

table.insert(result, {
	key = "<leader>m",
	description = "Major",
	mode = "n",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
})

for _, content in pairs(contents) do
	local bind = vim.deepcopy(content)
	bind.key = "<leader>m" .. bind.key
	bind.mode = "n"
	bind.buffer = nil
	bind.silent = true
	bind.noremap = true
	bind.nowait = false
	table.insert(result, bind)
end

return result
