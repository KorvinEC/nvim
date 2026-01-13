local gruvbox = require("gruvbox")
local palette = gruvbox.palette

vim.cmd.hi(
  string.format(
    "WinBar guifg=%s guibg=%s",
    palette.bright_green,
    palette.dark0
  )
)

vim.cmd.hi(
  string.format(
    "WinBarNC guifg=%s guibg=%s",
    palette.dark_green,
    palette.dark0
  )
)

local mode_map = {
  ['n']     = 'NORMAL',
  ['no']    = 'O-PENDING',
  ['nov']   = 'O-PENDING',
  ['noV']   = 'O-PENDING',
  ['no\22'] = 'O-PENDING',
  ['niI']   = 'NORMAL',
  ['niR']   = 'NORMAL',
  ['niV']   = 'NORMAL',
  ['nt']    = 'NORMAL',
  ['ntT']   = 'NORMAL',
  ['v']     = 'VISUAL',
  ['vs']    = 'VISUAL',
  ['V']     = 'V-LINE',
  ['Vs']    = 'V-LINE',
  ['\22']   = 'V-BLOCK',
  ['\22s']  = 'V-BLOCK',
  ['s']     = 'SELECT',
  ['S']     = 'S-LINE',
  ['\19']   = 'S-BLOCK',
  ['i']     = 'INSERT',
  ['ic']    = 'INSERT',
  ['ix']    = 'INSERT',
  ['R']     = 'REPLACE',
  ['Rc']    = 'REPLACE',
  ['Rx']    = 'REPLACE',
  ['Rv']    = 'V-REPLACE',
  ['Rvc']   = 'V-REPLACE',
  ['Rvx']   = 'V-REPLACE',
  ['c']     = 'COMMAND',
  ['cv']    = 'EX',
  ['ce']    = 'EX',
  ['r']     = 'REPLACE',
  ['rm']    = 'MORE',
  ['r?']    = 'CONFIRM',
  ['!']     = 'SHELL',
  ['t']     = 'TERMINAL',
}

-- Took from https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/utils/mode.lua
function GetCurrentMode()
  local mode_code = vim.api.nvim_get_mode().mode
  if mode_map[mode_code] == nil then
    return mode_code
  end
  return mode_map[mode_code]
end

vim.opt.winbar = "[%n] %<%f %h%w%m%r%=%l | %c%V"
vim.opt.statusline = "%<%t%=%P %y"

vim.opt.laststatus = 3
