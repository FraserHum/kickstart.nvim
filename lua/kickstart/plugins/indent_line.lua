return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {
      indent = {
        char = '▏',
      },
    },
    config = function()
      local hooks = require 'ibl.hooks'

      -- For space indentation:
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)

      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)

      require('ibl').setup()
    end,
  },
}
