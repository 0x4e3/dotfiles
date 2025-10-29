local function load_config()
  local config = {
    calendar = {
      click_script = "open -a Calendar"
    },
    icons = "sf-symbols", -- alternatively available: NerdFont
    paddings = 3,
    group_paddings = 5,
    font = {
      text = "JetBrainsMono Nerd Font",    -- Used for text
      numbers = "JetBrainsMono Nerd Font", -- Used for numbers
      style_map = {
        ["Regular"] = "Regular",
        ["Semibold"] = "Medium",
        ["Bold"] = "SemiBold",
        ["Heavy"] = "Bold",
        ["Black"] = "ExtraBold",
      },
    },
  }
  return config
end

return load_config()
