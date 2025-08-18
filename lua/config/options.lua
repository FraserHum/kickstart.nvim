-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.title = true
vim.opt.titlelen = 0 -- do not shorten title
vim.opt.titlestring = "%{fnamemodify(getcwd(), ':p:h:t')} %t%( %M%)%( (%{expand(\"%:~:h\")})%)%a - Nvim"
