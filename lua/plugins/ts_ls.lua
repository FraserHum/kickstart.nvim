-- ~/.config/nvim/lua/plugins/lsp-overrides.lua

return {
  -- Target the nvim-lspconfig plugin
  "neovim/nvim-lspconfig",

  -- opts will be merged with the default options configured by LazyVim
  opts = {
    -- The `servers` table is where you configure individual LSPs
    servers = {
      -- We are targeting the TypeScript server
      vtsls = {
        -- This is the exact same solution as before, now placed in the
        -- correct location for LazyVim to apply it.
        root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json"),
      },
    },
  },
}
