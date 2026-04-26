local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

-- Create the language indicator item
local language = sbar.add("item", "widgets.language", {
  position = "right",
  icon = {
    string = "??",
    font = {
      style = settings.font.style_map["Regular"],
      size = 12.0,
    },
    padding_right = -4,
    padding_left = 2,
  },
  update_freq = 2
})

-- Function to update language display
local function update_language()
  sbar.exec("defaults read com.apple.HIToolbox AppleCurrentKeyboardLayoutInputSourceID 2>/dev/null", function(current_input)
    local icon = "??"
    
    if current_input then
      if string.find(current_input, "US") or string.find(current_input, "English") or string.find(current_input, "ABC") then
        icon = "EN"
      elseif string.find(current_input, "Russian") or string.find(current_input, "RU") then
        icon = "RU"
      end
    end
    
    language:set({
      icon = {
        string = icon,
      }
    })
  end)
end

-- Update the language indicator on routine events
language:subscribe("routine", function()
  update_language()
end)

-- Initial update
update_language()

sbar.add("item", "widgets.language.padding", {
  position = "right",
  width = settings.group_paddings
})

sbar.add("bracket", "widgets.language.bracket", { language.name }, {
  background = { color = colors.bg1 }
})