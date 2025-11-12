local vim = vim
local M = {}

local logger_use_manage = require("application.use_cases.logger")
local jumper_use_manage = require("application.use_cases.jumper")
local plugin = require("infraestrucuture.plugins.lsp")
local mason_lspconfig = plugin.mason_lspconfig
local blink_cmp = plugin.blink_cmp
local snacks = plugin.snacks

local severity = vim.diagnostic.severity
vim.diagnostic.config({
  signs = {
    text = {
      -- [severity.ERROR] = " ",
      [severity.ERROR] = " ", -- error
      -- [severity.WARN] = " ",
      [severity.WARN] = " ", -- warning
      -- [severity.INFO] = " ",
      [severity.INFO] = " ", -- info
      -- [severity.HINT] = "󰌵",
      [severity.HINT] = "󰌶", -- hint (added a nice lightbulb icon)
    },
  },
})

local blink_capabilities = blink_cmp.get_lsp_capabilities()
local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
lsp_capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local capabilities = vim.tbl_deep_extend("force", blink_capabilities, lsp_capabilities)
local servers = mason_lspconfig.get_installed_servers()
-- local servers = vim.tbl_filter(function(s)
-- 	return s ~= "tsserver" and s ~= "ts_ls"
-- end, installed_servers)

for _, server in ipairs(servers) do
  local config = { capabilities = capabilities }
  local message = {
    module = "adapters/lsp",
    func = "setup",
    server = server,
    config = config,
  }

  logger_use_manage.debug(message)
  -- require("lspconfig")[server].setup(config)
  -- print(vim.inspect(config))

  vim.lsp.config(server, config)
  vim.lsp.enable(servers)
end

M.declaration = function(options)
  local message = {
    module = "adapters/lsp",
    func = "declaration",
    options = options,
  }
  logger_use_manage.debug(message)

  if options.type == "remote" then
    return jumper_use_manage.timer({
      action = function(match)
        vim.api.nvim_win_call(match.win, function()
          vim.api.nvim_win_set_cursor(match.win, match.pos)
          snacks.picker.lsp_declarations()
        end)
      end,
    })
  end

  snacks.picker.lsp_declarations()
end

M.definition = function(options)
  local message = {
    module = "adapters/lsp",
    func = "definition",
    options = options,
  }
  logger_use_manage.debug(message)

  if options.type == "remote" then
    return jumper_use_manage.timer({
      action = function(match)
        vim.api.nvim_win_call(match.win, function()
          vim.api.nvim_win_set_cursor(match.win, match.pos)
          snacks.picker.lsp_definitions()
        end)
      end,
    })
  end

  snacks.picker.lsp_definitions()
end

M.implementation = function(options)
  local message = {
    module = "adapters/lsp",
    func = "implementation",
    options = options,
  }
  logger_use_manage.debug(message)

  if options.type == "remote" then
    return jumper_use_manage.timer({
      action = function(match)
        vim.api.nvim_win_call(match.win, function()
          vim.api.nvim_win_set_cursor(match.win, match.pos)
          vim.lsp.buf.implementation()
        end)
      end,
    })
  end

  vim.lsp.buf.implementation()
end

M.references = function(options)
  local message = {
    module = "adapters/lsp",
    func = "references",
    options = options,
  }
  logger_use_manage.debug(message)

  if options.type == "remote" then
    return jumper_use_manage.timer({
      action = function(match)
        vim.api.nvim_win_call(match.win, function()
          vim.api.nvim_win_set_cursor(match.win, match.pos)

          snacks.picker.lsp_references()
        end)
      end,
    })
  end

  snacks.picker.lsp_references()
end

M.typedefinition = function(options)
  local message = {
    module = "adapters/lsp",
    func = "typedefinition",
  }
  logger_use_manage.debug(message)

  if options.type == "remote" then
    return jumper_use_manage.timer({
      action = function(match)
        vim.api.nvim_win_call(match.win, function()
          vim.api.nvim_win_set_cursor(match.win, match.pos)
          vim.lsp.buf.type_definition()
        end)
      end,
    })
  end

  vim.lsp.buf.type_definition()
end

M.show_signature = function()
  local message = {
    module = "adapters/lsp",
    func = "show_signature",
  }
  logger_use_manage.debug(message)

  vim.lsp.buf.signature_help()
end

M.show_documentation = function()
  local message = {
    module = "adapters/lsp",
    func = "show_documentation",
  }
  logger_use_manage.debug(message)

  vim.lsp.buf.hover()
end

M.type_definition = function()
  local message = {
    module = "adapters/lsp",
    func = "type_definition",
  }
  logger_use_manage.debug(message)

  vim.lsp.buf.type_definition()
end

M.show_code_action = function()
  local message = {
    module = "adapters/lsp",
    func = "show_code_action",
  }
  logger_use_manage.debug(message)

  vim.lsp.buf.code_action()
end

M.show_references = function()
  local message = {
    module = "adapters/lsp",
    func = "show_references",
  }
  logger_use_manage.debug(message)

  snacks.picker.lsp_references()
end

M.format = function()
  local message = {
    module = "adapters/lsp",
    func = "format",
  }
  logger_use_manage.debug(message)

  vim.lsp.buf.format({ async = true })
end

M.diagnostics = function()
  local message = {
    module = "adapters/lsp",
    func = "diagnostics",
  }
  logger_use_manage.debug(message)

  vim.lsp.diagnostic()
end

M.info = function()
  local message = {
    module = "adapters/lsp",
    func = "info",
  }
  logger_use_manage.debug(message)

  vim.cmd("LspInfo")
end

M.get_symbol = function()
  local message = {
    module = "adapters/lsp",
    func = "get_symbol",
  }
  logger_use_manage.debug(message)

  snacks.picker.lsp_symbols()
end

return M
