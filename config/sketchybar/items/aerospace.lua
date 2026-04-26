-- items/aerospace.lua
local colors = require("colors")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local query_workspaces =
	"aerospace list-workspaces --all --format '%{workspace}%{monitor-appkit-nsscreen-screens-id}' --json"

local workspaces = {}
local workspace_brackets = {}

local function updateWindows()
	local get_windows = "aerospace list-windows --monitor all --format '%{workspace}%{app-name}' --json"
	sbar.exec(get_windows, function(workspace_and_windows)
		local workspace_apps = {}
		for _, entry in ipairs(workspace_and_windows) do
			local workspace_index = entry.workspace
			local app = entry["app-name"]
			if workspace_apps[workspace_index] == nil then
				workspace_apps[workspace_index] = {}
			end
			table.insert(workspace_apps[workspace_index], app)
		end

		-- Update each workspace with app icons
		for workspace_index, workspace in pairs(workspaces) do
			local apps = workspace_apps[workspace_index] or {}
			local icon_line = ""
			local no_app = true
			for i, app in ipairs(apps) do
				no_app = false
				local lookup = app_icons[app]
				local icon = ((lookup == nil) and app_icons["Default"] or lookup)
				icon_line = icon_line .. icon
			end

			if no_app then
				icon_line = "—"
			end

			sbar.animate("tanh", 10, function()
				-- Always show workspace, even if empty
				workspace:set({
					icon = { drawing = true },
					label = { string = icon_line, drawing = true },
					background = { drawing = true },
				})
				if workspace_brackets[workspace_index] then
					workspace_brackets[workspace_index]:set({
						background = { drawing = true }
					})
				end
			end)
		end
	end)
end

sbar.exec(query_workspaces, function(workspaces_and_monitors)
	for _, entry in ipairs(workspaces_and_monitors) do
		local workspace_index = entry.workspace

		local workspace = sbar.add("item", "aerospace.workspace." .. workspace_index, {
			icon = {
				font = { family = settings.font.numbers },
				string = workspace_index,
				padding_left = 8,
				padding_right = 8,
				color = colors.white,
				highlight_color = colors.red,
			},
			label = {
				padding_right = 10,
				color = colors.grey,
				highlight_color = colors.white,
				font = "sketchybar-app-font:Regular:16.0",
				y_offset = -1,
			},
			padding_right = 1,
			padding_left = 1,
			background = {
				color = colors.bg1,
				border_width = 1,
				height = 26,
				border_color = colors.black,
			},
		})

		-- Single item bracket for workspace items to achieve double border on highlight
		local workspace_bracket = sbar.add("bracket", { workspace.name }, {
			background = {
				color = colors.transparent,
				border_color = colors.bg2,
				height = 28,
				border_width = 2
			}
		})

		-- Padding space
		sbar.add("item", "aerospace.padding." .. workspace_index, {
			script = "",
			width = settings.group_paddings * 0.5,
		})

		workspaces[workspace_index] = workspace
		workspace_brackets[workspace_index] = workspace_bracket

		-- Subscribe to aerospace workspace changes for highlighting
		workspace:subscribe("aerospace_workspace_change", function(env)
			local focused_workspace = env.FOCUSED_WORKSPACE
			local is_focused = focused_workspace == workspace_index

			sbar.animate("tanh", 10, function()
				workspace:set({
					icon = { highlight = is_focused },
					label = { highlight = is_focused },
					background = { border_color = is_focused and colors.black or colors.bg2 }
				})
				workspace_bracket:set({
					background = { border_color = is_focused and colors.grey or colors.bg2 }
				})
			end)
		end)

		-- Set initial focused workspace
		sbar.exec("aerospace list-workspaces --focused", function(focused_workspace)
			local focused = focused_workspace:match("^%s*(.-)%s*$")
			if focused == workspace_index then
				workspace:set({
					icon = { highlight = true },
					label = { highlight = true },
					background = { border_color = colors.black }
				})
				workspace_bracket:set({
					background = { border_color = colors.grey }
				})
			end
		end)
	end

	-- Initial window update
	updateWindows()

	-- Subscribe to aerospace focus changes to update windows
	local observer = sbar.add("item", {
		drawing = false,
		updates = true,
	})

  -- Subscribe to aerospace special event on workspace change
	observer:subscribe("aerospace_focus_change", function()
		updateWindows()
	end)

	observer:subscribe("front_app_switched", function()
		updateWindows()
	end)

  observer:subscribe("space_windows_change", function()
    updateWindows()
  end)
end)