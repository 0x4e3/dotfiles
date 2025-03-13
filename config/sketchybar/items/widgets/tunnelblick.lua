local colors = require("colors")
local app_icons = require("helpers.app_icons")

local lookup = app_icons["OpenVPN Connect"]

local tunnelblick = sbar.add("item", "widgets.tunnelblick", {
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

tunnelblick:subscribe({"routine", "system_woke"}, function()
  sbar.exec("osascript helpers/tunnelblick.scpt", function(connection_status)
    if connection_status == "CONNECTED\n" then
      tunnelblick:set({ 
        icon = {color = colors.green},
        background = { color = colors.bg2 },
      })  
    else
      tunnelblick:set({ 
        icon = {color = colors.yellow},
        background = { color = colors.bg1 },
      })  
    end
  end)
end)
