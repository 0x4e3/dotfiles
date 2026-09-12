-- items/aerospace.lua
local colors = require("colors")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local query_workspaces =
	"aerospace list-workspaces --all --format '%{workspace}%{monitor-appkit-nsscreen-screens-id}' --json"

local workspaces = {}
local workspace_brackets = {}
local workspace_paddings = {}
local superscript_digits = {
	["0"] = "⁰",
	["1"] = "¹",
	["2"] = "²",
	["3"] = "³",
	["4"] = "⁴",
	["5"] = "⁵",
	["6"] = "⁶",
	["7"] = "⁷",
	["8"] = "⁸",
	["9"] = "⁹",
}

local function superscript_number(number)
	return tostring(number):gsub("%d", superscript_digits)
end

local function update_workspace_displays()
	sbar.exec(query_workspaces, function(workspaces_and_monitors)
		for _, entry in ipairs(workspaces_and_monitors) do
			local workspace_index = entry.workspace
			local display = entry["monitor-appkit-nsscreen-screens-id"]

			if workspaces[workspace_index] then
				workspaces[workspace_index]:set({ display = display })
				workspace_brackets[workspace_index]:set({ display = display })
				workspace_paddings[workspace_index]:set({ display = display })
			end
		end
	end)
end

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
			local app_counts = {}
			local app_order = {}
			for _, app in ipairs(apps) do
				if app_counts[app] == nil then
					app_counts[app] = 0
					table.insert(app_order, app)
				end
				app_counts[app] = app_counts[app] + 1
			end

			for _, app in ipairs(app_order) do
				local icon = app_icons[app] or app_icons.Default
				local count = app_counts[app]
				icon_line = icon_line .. icon
				if count > 1 then
					icon_line = icon_line .. superscript_number(count)
				end
			end

			if #apps == 0 then
				icon_line = "-"
			end

			local label = { string = icon_line, drawing = true }
			if #apps == 0 then
				label = {
					string = "—",
					drawing = true,
					width = 18,
					align = "center",
					padding_left = 0,
					padding_right = 10,
					font = {
						family = settings.font.text,
						size = 16.0,
					},
				}
			else
				label.font = "sketchybar-app-font:Regular:16.0"
			end

			sbar.animate("tanh", 10, function()
				-- Always show workspace, even if empty
				workspace:set({
					icon = { drawing = true },
					label = label,
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
			click_script = "aerospace workspace " .. workspace_index,
			display = entry["monitor-appkit-nsscreen-screens-id"],
		})

		-- Single item bracket for workspace items to achieve double border on highlight
		local workspace_bracket = sbar.add("bracket", { workspace.name }, {
			background = {
				color = colors.transparent,
				border_color = colors.bg2,
				height = 28,
				border_width = 2
			},
			display = entry["monitor-appkit-nsscreen-screens-id"],
		})

		-- Padding space
		local workspace_padding = sbar.add("item", "aerospace.padding." .. workspace_index, {
			script = "",
			width = settings.group_paddings * 0.5,
			display = entry["monitor-appkit-nsscreen-screens-id"],
		})

		workspaces[workspace_index] = workspace
		workspace_brackets[workspace_index] = workspace_bracket
		workspace_paddings[workspace_index] = workspace_padding

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
	update_workspace_displays()

	-- Subscribe to aerospace focus changes to update windows
	local observer = sbar.add("item", {
		drawing = false,
		updates = true,
	})

	-- Subscribe to aerospace special event on workspace change
	observer:subscribe("aerospace_focus_change", function()
		updateWindows()
		update_workspace_displays()
	end)

	observer:subscribe("front_app_switched", function()
		updateWindows()
	end)


	observer:subscribe("space_windows_change", function()
		updateWindows()
	end)

	observer:subscribe("display_change", update_workspace_displays)
end)
