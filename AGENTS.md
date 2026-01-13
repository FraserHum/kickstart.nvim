# AGENTS.md - Neovim Configuration

This is a LazyVim-based Neovim configuration written entirely in Lua.

## Project Structure

```
~/.config/nvim/
├── init.lua                    # Entry point - bootstraps lazy.nvim
├── lazy-lock.json              # Plugin version lock (auto-generated, DO NOT EDIT)
├── lazyvim.json                # LazyVim extras configuration
├── stylua.toml                 # Lua formatter configuration
├── lua/
│   ├── config/
│   │   ├── autocmds.lua        # Custom autocommands
│   │   ├── keymaps.lua         # Custom key mappings
│   │   ├── lazy.lua            # lazy.nvim plugin manager setup
│   │   └── options.lua         # Vim options
│   └── plugins/
│       └── *.lua               # Plugin specifications (one per file)
└── spell/                      # Spell files (auto-generated)
```

## Build/Lint/Test Commands

### Formatting

```bash
# Format all Lua files with stylua
stylua lua/

# Format a single file
stylua lua/plugins/example.lua

# Check formatting without applying
stylua --check lua/
```

### Linting

```bash
# Lint with luacheck (if installed)
luacheck lua/

# Lint single file
luacheck lua/plugins/example.lua
```

### Testing

This configuration does not have unit tests. To validate changes:

1. Open Neovim: `nvim`
2. Check for errors: `:checkhealth`
3. Verify plugins loaded: `:Lazy`
4. Check LSP status: `:LspInfo`

### Plugin Management (in Neovim)

- `:Lazy` - Open plugin manager UI
- `:Lazy sync` - Update plugins and lockfile
- `:Lazy health` - Check plugin health
- `:Lazy profile` - Profile startup time

## Code Style Guidelines

### Formatting (stylua.toml)

- Indent: 2 spaces (no tabs)
- Line width: 120 characters
- Use `stylua` for all formatting

### File Organization

1. One plugin specification per file in `lua/plugins/`
2. Use descriptive filenames matching the plugin purpose (e.g., `colorscheme.lua`, `completions.lua`)
3. Keep `lua/config/` files minimal - prefer LazyVim defaults

### Plugin Specification Pattern

Always return a table (or list of tables) from plugin files:

```lua
-- Simple plugin with options
return {
  "author/plugin-name",
  opts = {
    option1 = "value",
  },
}

-- Multiple related plugins
return {
  { "plugin/one" },
  { "plugin/two", opts = { ... } },
}

-- Disable a file temporarily
-- stylua: ignore
if true then return {} end
```

### LazyVim Plugin Overrides

```lua
-- Override LazyVim plugin options
return {
  "existing/plugin",
  opts = {
    -- These merge with LazyVim defaults
  },
}

-- Override with function for complex merging
return {
  "existing/plugin",
  opts = function(_, opts)
    -- Modify opts table
    table.insert(opts.sources, { name = "new_source" })
  end,
}

-- Disable a LazyVim plugin
return {
  "plugin/to-disable",
  enabled = false,
}
```

### Lazy Loading

- Use `event = "VeryLazy"` for non-critical plugins
- Use `keys = { ... }` for plugins triggered by keymaps
- Use `ft = "filetype"` for filetype-specific plugins
- Use `cmd = "Command"` for command-triggered plugins

### Naming Conventions

- **Variables**: `snake_case` (e.g., `local my_variable = ...`)
- **Functions**: `snake_case` (e.g., `local function apply_rainbow()`)
- **Constants/Tables**: `snake_case` (e.g., `local dark_palette = { ... }`)
- **Highlight groups**: `PascalCase` (e.g., `RainbowRed`, `ErrorMsg`)
- **Autocommand groups**: `PascalCase` (e.g., `RainbowHighlights`)

### Import Style

```lua
-- Inline requires for one-time use
require("config.lazy")

-- Local variable for repeated use
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Lazy require in functions
local function my_func()
  require("telescope.builtin").find_files()
end
```

### Vim API Usage

```lua
-- Options
vim.opt.title = true
vim.opt.clipboard = "unnamedplus"
vim.g.clipboard = { ... }  -- Global variables

-- Autocommands
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("GroupName", { clear = true }),
  callback = function()
    -- handler
  end,
})

-- Keymaps (prefer LazyVim's keymap handling in plugin specs)
vim.keymap.set("n", "<leader>xx", function() ... end, { desc = "Description" })

-- Highlights
vim.api.nvim_set_hl(0, "HighlightGroup", { fg = "#ffffff" })
```

### Error Handling

```lua
-- Check for API availability
if not (vim.uv or vim.loop).fs_stat(path) then
  -- handle missing file
end

-- Shell command error handling
if vim.v.shell_error ~= 0 then
  vim.api.nvim_echo({
    { "Error message:\n", "ErrorMsg" },
    { output, "WarningMsg" },
  }, true, {})
end
```

### Comments

```lua
-- Single line comment for explanations

-- Multi-line comments for documentation
-- Line 2 of documentation

-- stylua: ignore  -- Disable formatting for next line
```

## Files NOT to Modify

- `lazy-lock.json` - Auto-generated plugin lockfile
- `spell/*.spl` - Compiled spell files
- `.neoconf.json` - LSP configuration (modify with care)

## Key Technologies

- **Plugin Manager**: lazy.nvim
- **Distribution**: LazyVim (provides sensible defaults)
- **Colorscheme**: Everforest
- **Completion**: blink.cmp
- **AI**: Avante with opencode ACP provider
- **Languages**: Go, Python, TypeScript, Docker, Terraform, SQL, Markdown, YAML

## LazyVim Extras Enabled

See `lazyvim.json` for full list. Key extras:
- AI: avante, copilot
- Formatting: prettier
- Linting: eslint
- Testing: neotest
- DAP: debugging support
- Editor: leap, mini-diff, mini-move, refactoring
