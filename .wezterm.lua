-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Ayu Dark (Gogh)'
config.colors = {
  -- Overrides the text color when the current cell is occupied by the cursor
  cursor_fg = 'black',

}


config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = 'NeverPrompt'

local act = wezterm.action

config.keys = {
  {
    key = 'b',
    mods = 'SHIFT|CTRL',
    action = act.RotatePanes 'CounterClockwise',
  },
  { key = 'n', mods = 'SHIFT|CTRL', action = act.RotatePanes 'Clockwise' },
}



-- and finally, return the configuration to wezterm
return config
