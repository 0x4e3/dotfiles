local colors = require("colors")
local app_icons = require("helpers.app_icons")

local lookup = app_icons["Telegram"]

local telegram = sbar.add("item", "widgets.telegram", {
  position = "right",
  icon = {
    font = "sketchybar-app-font:Regular:14.0",
    string = lookup,
    padding_right = 1,
    padding_left = 8,
  },
  background = { color = colors.bg1 },
  update_freq = 10,
})

telegram:subscribe({"routine", "system_woke"}, function()
  sbar.exec("lsappinfo info -only StatusLabel Telegram", function(telegram_status)
    local found, _, messages = string.find(telegram_status, "(%d+)")
    if found then
      telegram:set({ 
        icon = {color = colors.red},
      })  
    else
      telegram:set({ 
        icon = {color = colors.white},
      })  
    end
  end)
end)

telegram:subscribe("mouse.clicked", function()
  sbar.exec("open -a 'Telegram'")
end)

