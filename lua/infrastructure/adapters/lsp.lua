local vim = vim
local M = {}

local make_logged = require("application.helpers.make_logged")
local jumper_use_case = require("application.use_cases.jumper")
local plugin = require("infrastructure.plugins.lsp")
local mason_lspconfig = plugin.mason_lspconfig
local blink_cmp = plugin.blink_cmp
local snacks = plugin.snacks

local severity = vim.diagnostic.severity
vim.diagnostic.config({
  signs = {
    text = {
      -- [severity.ERROR] = " ",
      [severity.ERROR] = " ", -- error
      -- [severity.WARN] = " ",
      [severity.WARN] = " ", -- warning
      -- [severity.INFO] = " ",
      [severity.INFO] = " ", -- info
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

local server_overrides = {
  ts_ls = {
    root_dir = function(bufnr, on_dir)
      local lock_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
      local project_root = vim.fs.root(bufnr, lock_markers) or vim.fs.root(bufnr, { ".git" })
      local deno_root = vim.fs.root(bufnr, { "deno.json", "deno.jsonc" })
      local deno_lock_root = vim.fs.root(bufnr, { "deno.lock" })

      if deno_lock_root and (not project_root or #deno_lock_root > #project_root) then
        return
      end

      if deno_root and project_root and #deno_root > #project_root then
        return
      end

      on_dir(project_root or vim.fn.getcwd())
    end,
  },
}

for _, server in ipairs(servers) do
  local config = vim.tbl_deep_extend("force", { capabilities = capabilities }, server_overrides[server] or {})

  vim.lsp.config(server, config)
  vim.lsp.enable(servers)
end

local navigate_dispatch = {
  declaration = function() snacks.picker.lsp_declarations() end,
  definition = function() snacks.picker.lsp_definitions() end,
  implementation = function() vim.lsp.buf.implementation() end,
  references = function() snacks.picker.lsp_references() end,
  typedefinition = function() vim.lsp.buf.type_definition() end,
}

M.navigate = function(type, options)
  local action = navigate_dispatch[type]

  if options.type == "remote" then
    jumper_use_case.timer({
      action = function(match)
        vim.api.nvim_win_call(match.win, function()
          vim.api.nvim_win_set_cursor(match.win, match.pos)
          action()
        end)
      end,
    })
    return
  end

  action()
end

M.restart = function()
  vim.cmd("LspRestart")
end

M.rename = function()
  vim.lsp.buf.rename()
end

M.show_signature = function()
  vim.lsp.buf.signature_help()
end

M.show_documentation = function()
  vim.lsp.buf.hover()
end

M.show_code_action = function()
  vim.lsp.buf.code_action()
end

M.format = function()
  vim.lsp.buf.format({ async = true })
end

M.diagnostics = function()
  vim.lsp.diagnostic()
end

M.info = function()
  vim.cmd("LspInfo")
end

M.get_symbol = function()
  snacks.picker.lsp_symbols()
end

return make_logged("adapters/lsp", M)
