local wezterm = require("wezterm")
local action = wezterm.action

local config = {
  color_scheme = "Tokyo Night",
  window_background_opacity = 0.75,
  macos_window_background_blur = 10,

  window_decorations = "RESIZE",
  window_padding = {
    left = 24,
    right = 24,
    top = 16,
    bottom = 16,
  },

  font = wezterm.font("PlemolJP Console NF", {
    weight = "Regular",
    stretch = "Normal",
    italic = false,
  }),
  font_size = 13.0,
  warn_about_missing_glyphs = false,

  initial_cols = 200,
  initial_rows = 75,

  use_fancy_tab_bar = false,
  enable_tab_bar = false,

  scrollback_lines = 100000,

  disable_default_key_bindings = true,

  use_ime = true,
  macos_forward_to_ime_modifier_mask = "SHIFT|CTRL",

  keys = {
    { key = "c", mods = "SUPER", action = action.CopyTo("ClipboardAndPrimarySelection") },
    { key = "n", mods = "SUPER", action = action.SpawnWindow },
    { key = "v", mods = "SUPER", action = action.PasteFrom("Clipboard") },
    { key = "v", mods = "CTRL|SHIFT", action = action.PasteFrom("Clipboard") },
  },
}

return config
