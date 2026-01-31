return {
  -- 1. Disable the default OmniSharp setup
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Explicitly disable the old OmniSharp server so it doesn't conflict
      opts.servers.omnisharp = nil
    end,
  },

  -- 2. Install the Roslyn Plugin
  {
    "seblj/roslyn.nvim",
    ft = "cs",
    opts = {
      -- Recommended settings for performance
      config = {
        settings = {},
      },
    },
  },

  -- 3. Ensure Mason doesn't try to auto-install OmniSharp anymore
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.registries = opts.registries or {
        "github:mason-org/mason-registry",
      }

      -- Add the extra registry for roslyn
      -- We use table.insert to avoid overwriting existing registries if any
      table.insert(opts.registries, "github:Crashdummyy/mason-registry")
      opts.ensure_installed = opts.ensure_installed or {}
      -- Filter out omnisharp if it's already in the list
      opts.ensure_installed = vim.tbl_filter(function(name)
        return name ~= "omnisharp"
      end, opts.ensure_installed)
    end,
  },
}
