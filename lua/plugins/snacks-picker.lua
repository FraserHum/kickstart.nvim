-- Configure snacks.nvim picker to show hidden files (dotfiles)
-- Toggle ignored files with <a-i> in picker, or I in explorer
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        -- Explorer: show hidden and ignored files by default
        -- Toggle with H (hidden) and I (ignored) keys
        explorer = {
          hidden = true,
          ignored = true,
        },
        -- Files picker: show hidden files
        -- Uses fd by default (auto-detected), falls back to rg or find
        files = {
          hidden = true,
        },
        -- Grep: search hidden files
        -- Uses rg (ripgrep) by default
        grep = {
          hidden = true,
        },
        -- Grep word under cursor
        grep_word = {
          hidden = true,
        },
      },
    },
  },
}
