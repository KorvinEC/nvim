local keyboard_state_monitor = {
  state_file = '/tmp/zmk_keyboard_state.json',
  cached_state = { caps = 'off', shift = 'off', smart_caps = 'off' },
  file_handle = nil,
  last_modified = 0
}

-- Initialize the monitor
function keyboard_state_monitor.init()
  -- Set up a timer to check the file periodically
  if not keyboard_state_monitor.timer then
    keyboard_state_monitor.timer = vim.loop.new_timer()

    -- Check the file every 200ms
    keyboard_state_monitor.timer:start(0, 200, vim.schedule_wrap(function()
      keyboard_state_monitor.check_file()
    end))

    -- Initial read
    keyboard_state_monitor.check_file()
  end
end

function keyboard_state_monitor.check_file()
  -- Get file modification time
  local stat = vim.loop.fs_stat(keyboard_state_monitor.state_file)
  if not stat then return end

  -- If file has been modified since last read
  if stat.mtime.sec > keyboard_state_monitor.last_modified then
    keyboard_state_monitor.read_file()
    keyboard_state_monitor.last_modified = stat.mtime.sec
  end
end

function keyboard_state_monitor.read_file()
  local file = io.open(keyboard_state_monitor.state_file, 'r')
  if not file then return end

  local content = file:read('*a')
  file:close()

  -- Parse JSON (basic method)
  local parsed = {}
  for state, value in content:gmatch('"(%w+)": "(%w+)"') do
    parsed[state] = value
  end

  -- Update cached state
  keyboard_state_monitor.cached_state = {
    caps = parsed.caps or 'off',
    shift = parsed.shift or 'off',
    smart_caps = parsed.smart_caps or 'off'
  }
end

function keyboard_state_monitor.get_status()
  -- Make sure we've initialized
  if not keyboard_state_monitor.timer then
    keyboard_state_monitor.init()
  end

  -- Build the output string
  local output = ''

  if keyboard_state_monitor.cached_state.caps == 'on' then
    output = 'CAPS'
  end

  if keyboard_state_monitor.cached_state.shift == 'on' then
    if output ~= '' then
      output = output .. '+'
    end
    output = output .. 'SHIFT'
  end

  if keyboard_state_monitor.cached_state.smart_caps == 'on' then
    if output ~= '' then
      output = output .. '+'
    end
    output = output .. 'SMART'
  end

  return output
end

function keyboard_state_monitor.get_color()
  local status = keyboard_state_monitor.get_status()

  if status:find('CAPS') then
    return { fg = '#f38ba8', gui = 'bold' } -- Bold red for CAPS
  elseif status:find('SHIFT') then
    return { fg = '#89dceb', gui = 'bold' } -- Cyan for SHIFT
  elseif status:find('SMART') then
    return { fg = '#fab387', gui = 'bold' } -- Orange for SMART CAPS
  else
    return { fg = '#a6e3a1' }               -- Green for normal
  end
end

-- Set up cleanup when Neovim exits
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    keyboard_state_monitor.cleanup()
  end
})

-- Initialize the monitor
keyboard_state_monitor.init()

-- Lualine component for keyboard state
local keyboard_status = {
  function()
    return keyboard_state_monitor.get_status()
  end,
  color = function()
    return keyboard_state_monitor.get_color()
  end,
  icon = { '⌨', align = 'right' },
  padding = { left = 1, right = 1 }
}


return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local lualine = require("lualine")

    lualine.setup({
      extensions = { 'oil', 'mason', 'lazy', 'quickfix', 'trouble' },
      options = {
        theme = 'gruvbox_dark',
        globalstatus = true,
        ignore_focus = { "snacks_picker_input", "snacks_terminal", "mcphub", "minifiles" },
      },
      sections = {
        lualine_c = {
          {
            'filename',
            file_status = true,    -- Displays file status (readonly status, modified status)
            newfile_status = true, -- Display new file status (new file means no write after created)
            path = 1,
            -- 0: Just the filename
            -- 1: Relative path
            -- 2: Absolute path
            -- 3: Absolute path, with tilde as the home directory
            -- 4: Filename and parent dir, with tilde as the home directory
            shorting_target = 40,
            -- Shortens path to leave 40 spaces in the window
            -- for other components. (terrible name, any suggestions?)
            symbols = {
              modified = '[󰻭]', -- Text to show when the file is modified.
              readonly = '[]', -- Text to show when the file is non-modifiable or readonly.
              unnamed = '[No Name]', -- Text to show for unnamed buffers.
              newfile = '[New]', -- Text to show for newly created file before first write
            }
          },
        },
        lualine_x = {
          keyboard_status,
          'lsp_status',
          'encoding',
          'fileformat',
          'filetype'
        },
      },
    })
  end
}
