local M = {}
local make_logged = require("application.helpers.make_logged")

local file_util = require("application.ports.adapter_registry").file_util()

M.setup = function()
  return require("application.ports.adapter_registry").searcher()
end

---@param opts? { location?: "buffer"|"project"|"directory", in_live?: boolean }
M.search = function(opts)
  local adapter = M.setup()
  local path = file_util.path()
  opts = opts or {}
  local location = opts.location or "buffer"
  local in_live = opts.in_live or false

  if location == "project" then
    path = file_util.project(location)
  end

  if location == "directory" then
    path = file_util.directory()
  end

  adapter.search({
    location = location,
    path = path,
    in_live = in_live,
  })
end

---@param opts? { location?: "buffer"|"project" }
M.search_selection = function(opts)
  local adapter = M.setup()
  local editor = require("application.ports.adapter_registry").editor()
  opts = opts or {}
  local location = opts.location or "buffer"

  local text = editor.visual_selection()
  local path = file_util.path()

  if location == "project" then
    path = file_util.project(location)
  end

  adapter.search({
    location = location,
    path = path,
    text = text,
  })
end

---@param opts? { location?: "buffer"|"project"|"directory" }
M.search_input = function(opts)
  local adapter = M.setup()
  local editor = require("application.ports.adapter_registry").editor()
  opts = opts or {}
  local location = opts.location or "buffer"

  local text = editor.prompt("Grep symbol: ")
  local path = file_util.path()

  if location == "project" then
    path = file_util.project(location)
  end

  if location == "directory" then
    path = file_util.directory()
  end

  adapter.search({
    location = location,
    path = path,
    text = text,
  })
end

---@param opts? { location?: "buffer"|"project"|"directory" }
M.search_hover = function(opts)
  local adapter = M.setup()
  local editor = require("application.ports.adapter_registry").editor()
  opts = opts or {}
  local location = opts.location or "buffer"

  local path = editor.current_path()
  local text = editor.cword()

  if location == "project" then
    path = file_util.project(location)
  end

  if location == "directory" then
    path = file_util.directory()
  end

  adapter.search({
    location = location,
    path = path,
    text = text,
  })
end

M.resume = function()
  local adapter = M.setup()

  adapter.resume()
end

M.search_link_next = function()
  local adapter = M.setup()

  adapter.search_link_next()
end

M.search_link_previous = function()
  local adapter = M.setup()

  adapter.search_link_previous()
end

M.keymaps = function()
  local adapter = M.setup()

  adapter.keymaps()
end

return make_logged("usecases/searcher", M)
