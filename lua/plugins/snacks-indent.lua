local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}

local dark_palette = {
  RainbowRed = "#f38ba8",
  RainbowYellow = "#f9e2af",
  RainbowBlue = "#89b4fa",
  RainbowOrange = "#fab387",
  RainbowGreen = "#a6e3a1",
  RainbowViolet = "#cba6f7",
  RainbowCyan = "#94e2d5",
}

local light_palette = {
  RainbowRed = "#e78284",
  RainbowYellow = "#df8e1d",
  RainbowBlue = "#04a5e5",
  RainbowOrange = "#ef9f76",
  RainbowGreen = "#41a12b",
  RainbowViolet = "#ca9ee6",
  RainbowCyan = "#81c8be",
}

return {
  {
    "HiPhish/rainbow-delimiters.nvim",
  },
  {
    "folke/snacks.nvim",
    opts = {
      indent = {
        enabled = true,
        char = "▏",
        animate = {
          enabled = false,
        },
        scope = {
          hl = highlight,
        },
        chunk = {
          enabled = true,
          char = {
            corner_bottom = "└",
            corner_top = "┌",
            horizontal = "─",
            vertical = "│",
          },
          hl = highlight,
        },
      },
    },
    init = function()
      local function apply_rainbow()
        local palette = (vim.o.background == "dark") and dark_palette or light_palette
        for group, color in pairs(palette) do
          vim.api.nvim_set_hl(0, group, { fg = color })
        end
      end

      apply_rainbow()

      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("RainbowHighlights", { clear = true }),
        callback = apply_rainbow,
      })

      vim.api.nvim_create_autocmd("OptionSet", {
        pattern = "background",
        group = vim.api.nvim_create_augroup("RainbowHighlightsBgSwitch", { clear = true }),
        callback = apply_rainbow,
      })

      vim.g.rainbow_delimiters = { highlight = highlight }
    end,
  },
}
