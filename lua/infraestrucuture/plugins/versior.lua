local ok_gitsigns, gitsigns = pcall(require, "gitsigns")
if not ok_gitsigns then
  return vim.notify("Failed to load plugin `lewis6991/gitsigns.nvim`")
end
gitsigns.setup()

local neogit_ok, neogit = pcall(require, "neogit")
if not neogit_ok then
  return vim.notify("Failed to load plugin `NeogitOrg/neogit`")
end

neogit.setup({
  use_default_keymaps = false,
  mappings = {
    commit_editor = {
      ["q"] = "Close",
      ["<c-c><c-c>"] = "Submit",
      ["<c-c><c-k>"] = "Abort",
      ["<m-p>"] = "PrevMessage",
      ["<m-n>"] = "NextMessage",
      ["<m-r>"] = "ResetMessage",
    },
    commit_editor_I = {
      ["<c-c><c-c>"] = "Submit",
      ["<c-c><c-k>"] = "Abort",
    },
    rebase_editor = {
      ["p"] = "Pick",
      ["r"] = "Reword",
      ["e"] = "Edit",
      ["s"] = "Squash",
      ["f"] = "Fixup",
      ["x"] = "Execute",
      ["d"] = "Drop",
      ["b"] = "Break",
      ["q"] = "Close",
      ["<cr>"] = "OpenCommit",
      ["gk"] = "MoveUp",
      ["gj"] = "MoveDown",
      ["<c-c><c-c>"] = "Submit",
      ["<c-c><c-k>"] = "Abort",
      ["[c"] = "OpenOrScrollUp",
      ["]c"] = "OpenOrScrollDown",
    },
    rebase_editor_I = {
      ["<c-c><c-c>"] = "Submit",
      ["<c-c><c-k>"] = "Abort",
    },
    finder = {
      ["<cr>"] = "Select",
      ["<c-c>"] = "Close",
      ["<esc>"] = "Close",
      ["<c-n>"] = "Next",
      ["<c-p>"] = "Previous",
      ["<down>"] = "Next",
      ["<up>"] = "Previous",
      ["<tab>"] = "InsertCompletion",
      ["<space>"] = "MultiselectToggleNext",
      ["<s-space>"] = "MultiselectTogglePrevious",
      ["<c-j>"] = "NOP",
      ["<ScrollWheelDown>"] = "ScrollWheelDown",
      ["<ScrollWheelUp>"] = "ScrollWheelUp",
      ["<ScrollWheelLeft>"] = "NOP",
      ["<ScrollWheelRight>"] = "NOP",
      ["<LeftMouse>"] = "MouseClick",
      ["<2-LeftMouse>"] = "NOP",
    },
    -- Setting any of these to `false` will disable the mapping.
    popup = {
      ["b"] = "BranchPopup",
      ["B"] = "BisectPopup",
      ["c"] = "CommitPopup",
      ["d"] = "DiffPopup",
      ["f"] = "FetchPopup",
      ["F"] = "PullPopup",
      ["h"] = "HelpPopup",
      ["i"] = "IgnorePopup",
      ["l"] = "LogPopup",
      ["m"] = "MergePopup",
      ["M"] = "RemotePopup",
      ["P"] = "PushPopup",
      ["O"] = "ResetPopup",
      ["r"] = "RebasePopup",
      ["t"] = "TagPopup",
      ["Y"] = "CherryPickPopup",
      ["Z"] = "WorktreePopup",
      ["z"] = "StashPopup",
      ["_"] = "RevertPopup",
      ["?"] = "HelpPopup",
    },
    status = {
      ["j"] = "MoveDown",
      ["k"] = "MoveUp",
      ["o"] = "OpenTree",
      ["q"] = "Close",
      ["I"] = "InitRepo",
      ["1"] = "Depth1",
      ["2"] = "Depth2",
      ["3"] = "Depth3",
      ["4"] = "Depth4",
      ["Q"] = "Command",
      ["<tab>"] = "Toggle",
      ["x"] = "Discard",
      ["s"] = "Stage",
      ["S"] = "StageUnstaged",
      ["<c-s>"] = "StageAll",
      ["u"] = "Unstage",
      ["K"] = "Untrack",
      ["U"] = "UnstageStaged",
      ["y"] = "ShowRefs",
      ["$"] = "CommandHistory",
      ["Y"] = "YankSelected",
      ["<c-r>"] = "RefreshBuffer",
      ["<cr>"] = "GoToFile",
      ["<s-cr>"] = "PeekFile",
      ["<c-v>"] = "VSplitOpen",
      ["<c-x>"] = "SplitOpen",
      ["<c-t>"] = "TabOpen",
      ["{"] = "GoToPreviousHunkHeader",
      ["}"] = "GoToNextHunkHeader",
      ["[c"] = "OpenOrScrollUp",
      ["]c"] = "OpenOrScrollDown",
      ["<c-k>"] = "PeekUp",
      ["<c-j>"] = "PeekDown",
      ["<c-n>"] = "NextSection",
      ["<c-p>"] = "PreviousSection",
    },
  },
})

print(vim.inspect(neogit))
-- neogit.lib.popup:builder()

local snacks_ok, snacks = pcall(require, "snacks")
if not snacks_ok then
  return vim.notify("Failed to load plugin `folke/snacks.nvim`")
end

-- snacks.setup()

local octo_ok, octo = pcall(require, "octo")
if not octo_ok then
  return vim.notify("Failed to load plugin `pwntester/octo.nvim`")
end

octo.setup()

return { gitsigns = gitsigns, neogit = neogit, snacks = snacks, octo = octo }
