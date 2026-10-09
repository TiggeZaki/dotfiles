local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

if wezterm.target_triple:find("windows") then
    config.default_prog = { "pwsh.exe" }
end
config.prefer_to_spawn_tabs = true

-- ---------------------------------------------------------------------------
-- Key bindings
-- ---------------------------------------------------------------------------

config.keys = {
    -- Alt+Shift+\
    {
        key = "|",
        mods = "ALT|SHIFT",
        action = act.SplitPane({
            direction = "Right",
            size = { Percent = 50 },
        }),
    },
    -- Alt+Shift+-
    {
        key = "=",
        mods = "ALT|SHIFT",
        action = act.SplitPane({
            direction = "Down",
            size = { Percent = 50 },
        }),
    },
}

-- ---------------------------------------------------------------------------
-- Appearance
-- ---------------------------------------------------------------------------

config.font = wezterm.font("HackGen Console NF")

config.font_size = 12.0

config.color_scheme = 'Campbell (Gogh)'

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

return config
