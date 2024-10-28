# Spec: Update chatbot to claudecode.nvim with Spacemacs keybindings

## Goal

Update the chatbot layer to use `coder/claudecode.nvim` as the primary Claude Code plugin and adopt the keybindings from the [Spacemacs Claude Code layer](https://www.spacemacs.org/layers/+tools/claude-code/README.html).

## Current State

- Plugin `coder/claudecode.nvim` is already in lazy specs but the plugin wrapper (`infrastructure/plugins/chatbot.lua`) has the require commented out
- Adapter (`infrastructure/adapters/chatbot.lua`) already maps claudecode actions to commands like `ClaudeCode`, `ClaudeCodeFocus`, `ClaudeCodeSend`, `ClaudeCodeStart`, `ClaudeCodeStop`
- Keybindings are under `<leader>$d` prefix (e.g. `<leader>$ds` for start)

## Target Keybindings

Keep existing `<leader>$d` prefix, add Spacemacs-inspired bindings:

| Key | Description | Command | claudecode.nvim command |
|-----|-------------|---------|------------------------|
| `<leader>$ds` | Start session | Start Claude Code | `:ClaudeCode` |
| `<leader>$dp` | Send prompt | Send prompt to Claude | `:ClaudeCodeSend` (visual + normal) |
| `<leader>$dc` | Continue | Continue conversation | `:ClaudeCode --continue` |
| `<leader>$dr` | Resume | Resume previous conversation | `:ClaudeCode --resume` |
| `<leader>$dl` | List sessions | List/switch sessions | `:ClaudeCode --resume` |
| `<leader>$db` | Switch buffer | Switch to Claude buffer | `:ClaudeCodeFocus` |
| `<leader>$dt` | Toggle window | Toggle Claude window | `:ClaudeCode` |
| `<leader>$dq` | Stop | Stop Claude Code | `:ClaudeCodeStop` |
| `<leader>$di` | Insert text | Send selection to Claude | `:ClaudeCodeSend` (visual) |
| `<leader>$dm` | Select model | Select model | `:ClaudeCodeSelectModel` |
| `<leader>$da` | Accept diff | Accept proposed changes | `:ClaudeCodeDiffAccept` |
| `<leader>$dx` | Deny diff | Reject proposed changes | `:ClaudeCodeDiffDeny` |
| `<leader>$df` | Add file | Add current file | `:ClaudeCodeAdd %` |

## Available claudecode.nvim commands

| Command | Purpose |
|---------|---------|
| `:ClaudeCode` | Toggle Claude Code terminal |
| `:ClaudeCodeFocus` | Smart focus/toggle terminal |
| `:ClaudeCodeSelectModel` | Choose model and open terminal |
| `:ClaudeCodeSend` | Send visual selection to Claude |
| `:ClaudeCodeAdd <file> [start] [end]` | Add file with optional line range |
| `:ClaudeCodeDiffAccept` | Accept proposed changes |
| `:ClaudeCodeDiffDeny` | Reject proposed changes |

## Files to modify

| File | Changes |
|------|---------|
| `domain/maps/chatbot.lua` | Update `<leader>$d` keybindings with new Spacemacs-inspired bindings |
| `application/use_cases/chatbot.lua` | Add new methods: `send_prompt`, `add_file`, `select_model`, `accept_diff`, `deny_diff` |
| `infrastructure/adapters/chatbot.lua` | Add adapter methods for new commands |
| `infrastructure/plugins/chatbot.lua` | Uncomment claudecode require |

## Notes

- Keep the existing `<leader>$d` prefix for Claude Code
- Keep OpenCode bindings under `<leader>$o`
- Some Spacemacs bindings (`send-escape`, `insert-newline`, `toggle-debug`) don't have direct claudecode.nvim command equivalents — omitted
