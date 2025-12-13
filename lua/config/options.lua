-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.title = true
vim.opt.titlelen = 0 -- do not shorten title
vim.opt.titlestring = "%{fnamemodify(getcwd(), ':p:h:t')} Nvim %t%( %M%)%( (%{expand(\"%:~:h\")})%)%a"

-- 1. Define the OSC 52 Provider
local function copy(lines, _)
  local content = table.concat(lines, "\n")
  local base64 = vim.base64.encode(content)
  local osc52 = string.format("\x1b]52;c;%s\x07", base64)
  if vim.env.TMUX then
    osc52 = string.format("\x1bPtmux;\x1b%s\x1b\\", osc52)
  end
  io.stdout:write(osc52)
end

local function paste()
  return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
end

vim.g.clipboard = {
  name = "OSC 52 Force",
  copy = {
    ["+"] = copy,
    ["*"] = copy,
  },
  paste = {
    ["+"] = paste,
    ["*"] = paste,
  },
}
vim.opt.clipboard = "unnamedplus"
