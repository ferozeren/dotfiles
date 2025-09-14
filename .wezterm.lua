-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

local act = wezterm.action
-- config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

-- config.default_prog = { 'pwsh', '-NoLogo' }
-- config.default_prog = { 'pwsh' }
-- config.default_prog = { 'C:\\Program Files\\PowerShell\\7\\pwsh.exe', '-NoLogo' }

-- config.enable_scroll_bar = true
-- sixel_support = true
-- config.default_prog = { 'pwsh.exe' }
-- config.enable_wayland = false

-- config.default_prog = Default_prog

-- This is where you actually apply your config choices
-- config.default_cursor_style = 'SteadyBlock'

config.default_cursor_style = "BlinkingBar"

-- config.animation_fps = 60
-- config.cursor_blink_ease_in = 'Constant'
-- config.cursor_blink_ease_out = 'Constant'
-- config.color_scheme = 'X::DotShare (terminal.sexy)'
-- config.color_scheme = 'Abernathy'
-- config.color_scheme = 'Campbell (Gogh)'
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_decorations = "NONE"
-- config.window_decorations = "RESIZE"
-- config.window_background_opacity = 0.9
-- config.window_background_opacity = 0.8
-- config.window_background_opacity = 0.8
-- config.window_background_opacity = 0.85
-- config.window_background_opacity = 0.7
-- config.kde_window_background_blur = true
-- config.window_background_opacity = 0 -- opacity as you please
-- config.kde_window_background_blur = true

-- config.window_background_opacity = 0.9
-- config.window_background_opacity = 0.9
-- config.window_background_opacity = 0.8
--config.kde_window_background_blur = true

-- config.initial_cols = 120
-- config.initial_rows = 28

config.initial_cols = 87
config.initial_rows = 28

-- config.initial_cols = 120
-- config.initial_rows= 24
-- config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

config.colors = {
	selection_fg = "none",
	selection_bg = "rgba:60% 50% 80% 10%",
}

function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

-- wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
-- 	local title = tab_title(tab)
-- 	if tab.is_active then
-- 		return {
-- 			{ Background = { Color = "black" } },
-- 			{ Text = " " .. title .. " " },
-- 		}
-- 	end
-- 	-- if tab.is_last_active then
-- 	-- 	-- Green color and append '*' to previously active tab.
-- 	-- 	return {
-- 	-- 		{ Background = { Color = "purple" } },
-- 	-- 		{ Text = " " .. title .. "*" },
-- 	-- 	}
-- 	-- end
-- 	-- if not tab.is_active and not tab.is_last_active then
-- 	-- 	return {
-- 	-- 		{ Background = { Color = "green" } },
-- 	-- 		{ Text = " " .. title .. " " },
-- 	-- 	}
-- 	-- end
-- 	return title
-- end)

-- config.tab_max_width = 16
-- config.font_size = 18
-- config.font_size = 16
--
-- config.font =  wezterm.font('JetBrainsMono Nerd Font Mono', { weight = 'Bold', italic = false })
config.font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Regular", italic = false })
config.font_size = 14
-- config.line_height = 1.175
-- config.font_size = 13
-- config.line_height = 1.1766
config.line_height = 1.1766
-- config.line_height = 1.2 --for font 13 and  tpp 16

-- config.font =  wezterm.font('Liga SFMono Nerd Font', { weight = 'Regular', italic = false })
-- config.font_size = 14
-- config.line_height = 1.3

-- config.font_size = 13
-- config.line_height = 1.2
-- config.line_height = 1.25

-- config.kde_window_background_blur = true

config.window_padding = {
	-- top =24, -- for 18 font size
	-- top =5, -- for 18 font size
	-- top=10, -- for 14 font size  and 1.175

	-- top = 7, -- for 14 font size  and 1.175
	top = 3, -- for 14 font size  and 1.175
	left = 2,
	right = 0,
	bottom = 0,

	-- top=16, -- for 13 font size  and 1.1766 /1.2
	-- left=2,
	-- right=0,
	-- bottom =0
} -- local wezterm = require 'wezterm'

-- config.window_frame = {
--   border_left_width = '1px',
--   border_right_width = '1px',
--   border_bottom_height = '1px',
--   border_top_height = '1px',
--   border_left_color = '#444444',
--   border_right_color = '#444444',
--   border_bottom_color = '#444444',
--   border_top_color = '#444444',
-- }

-- config.keys = {
--   {
--     key = 'n',
--     mods = 'SHIFT|CTRL',
--     action = wezterm.action.ToggleFullScreen,
--   },
-- }

-- local wezterm = require 'wezterm'

-- wezterm.on("gui-startup", function(cmd)
-- 	local screen = wezterm.gui.screens().main
-- 	local ratio = 0.7
-- 	local width, height = screen.width * ratio, screen.height * ratio
-- 	local tab, pane, window = wezterm.mux.spawn_window(cmd or {
-- 		position = { x = (screen.width - width) / 2, y = (screen.height - height) / 2 },
-- 	})
-- 	-- window:gui_window():maximize()
-- 	window:gui_window():set_inner_size(width, height)
-- end)

-- wezterm.on("gui-startup", function(cmd)
--   local screen            = wezterm.gui.screens().active
--   local ratio1            = 0.68
--   local ratio2            = 0.72
--   local width, height     = screen.width * ratio1, screen.height * ratio2
--   local tab, pane, window = wezterm.mux.spawn_window {
--     position = {
--       x = (screen.width - width) / 2,
--       y = (screen.height - height) / 2.5,
--       origin = 'ActiveScreen' }
--   }
--   -- window:gui_window():maximize()
--   window:gui_window():set_inner_size(width, height)
-- end)

config.inactive_pane_hsb = {
	-- saturation = 0.9,
	-- brightness = 0.8,
	saturation = 0.9,
	brightness = 0.6,
}
config.keys = {
	{
		key = "F11",
		mods = "",
		action = wezterm.action.ToggleFullScreen,
	},
	-- Same as CTRL SHIFT Z (ZOOM PANE)
	-- { key = "u", mods = "CTRL", action = act.TogglePaneZoomState },
	{ key = "u", mods = "ALT", action = act.TogglePaneZoomState },
	-- Move pane to new window (custom logic)
	{
		key = "u",
		mods = "SHIFT|ALT",
		action = wezterm.action_callback(function(win, pane)
			pane:move_to_new_window()
		end),
	},
	-- Split to the left (new pane on left, current pane moves right)
	{
		key = "H",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitPane({ direction = "Left", size = { Percent = 50 } }),
	},
	-- Split to the right (new pane on right, current pane stays left)
	{
		key = "L", -- Changed from 'L' to avoid debug overlay conflict
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitPane({ direction = "Right", size = { Percent = 50 } }),
	},
	-- Split to the top (new pane on top, current pane moves down)
	{
		key = "K",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitPane({ direction = "Up", size = { Percent = 50 } }),
	},
	-- Split to the bottom (new pane on bottom, current pane stays up)
	{
		key = "J",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitPane({ direction = "Down", size = { Percent = 50 } }),
	},

	-- Switching panes (Alt + Shift + H/J/K/L)
	{ key = "H", mods = "ALT|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "L", mods = "ALT|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "K", mods = "ALT|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "J", mods = "ALT|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },
	-- { key = "H", mods = "ALT|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
	-- { key = "L", mods = "ALT|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
	-- { key = "K", mods = "ALT|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
	-- { key = "J", mods = "ALT|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },

	-- -- Cycle to the next pane
	--     {key="RightArrow", mods="CMD", action=wezterm.action{ActivatePaneDirection="Next"}},
	-- -- Cycle to the previous pane
	--     {key="LeftArrow", mods="CMD", action=wezterm.action{ActivatePaneDirection="Prev"}},
	-- Cycle to the next pane
	-- {key='j', mods="CTRL", action=wezterm.action{ActivatePaneDirection='Next'}},
	-- Cycle to the previous pane
	{ key = "h", mods = "CTRL", action = wezterm.action({ ActivatePaneDirection = "Prev" }) },
	{ key = "j", mods = "CTRL", action = wezterm.action({ ActivatePaneDirection = "Next" }) },

	{
		key = "`",
		mods = "CTRL",
		action = wezterm.action.SplitPane({ direction = "Down", size = { Percent = 25 } }),
	},

	{
		key = "k",
		mods = "CTRL",
		action = act.RotatePanes("CounterClockwise"),
	},
	{ key = ";", mods = "CTRL", action = act.RotatePanes("Clockwise") },
	--   { key = 'j', mods = 'CTRL', action = act.Multiple {
	--     act.ActivatePaneDirection('Up'),
	--     act.TogglePaneZoomState
	--     , -- Focus the top pane after unzooming
	-- }},

	-- {
	--   key = 'b',
	--   mods = 'CTRL',
	--   action = act.RotatePanes 'CounterClockwise',
	-- },
	-- { key = 'n', mods = 'CTRL', action = act.RotatePanes 'Clockwise' },
	--   { key = 'j', mods = 'CTRL', action = act.Multiple {
	--     act.ActivatePaneDirection('Up'),
	--     act.TogglePaneZoomState
	--     , -- Focus the top pane after unzooming
	-- }},
	-- Debug overlay (Ctrl + Shift + O)
	{ key = "O", mods = "CTRL|SHIFT", action = wezterm.action.ShowDebugOverlay },

	--- Languages :
	-- {
	--   key = 'R',
	--   mods = 'CTRL|SHIFT',
	--   action = wezterm.action.SplitPane {
	--     direction = 'Right',
	--     command = { args = { 'cargo', 'run' } },
	--     size = { Percent = 50 },
	--   },

	-- This will create a new split and run the `top` program inside it
	{
		key = "R",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitPane({
			direction = "Right",
			command = { args = { "cargo", " run" } },
			size = { Percent = 50 },
		}),
	},

	{
		key = "w",
		mods = "CTRL",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},

	-- TO resize a pane:

	-- {
	--   key = 'h',
	--   mods = 'LEADER',
	--   action = wezterm.action.AdjustPaneSize { 'Left', 5 },
	-- },

	-- {
	--   key = 'j',
	--   mods = 'LEADER',
	--   action = wezterm.action.AdjustPaneSize { 'Down', 5 },
	-- },
	-- { key = 'k',
	--   mods = 'LEADER',
	--   action = wezterm.action.AdjustPaneSize { 'Up', 5 } },
	-- {
	--   key = 'l',
	--   mods = 'LEADER',
	--   action = wezterm.action.AdjustPaneSize { 'Right', 5 },
	-- },

	-- Have to releae ctrl a then press neither hjkl
	-- Lowercase bindings
	-- {
	--   key = 'h',
	--   mods = 'LEADER',
	--   action = act.AdjustPaneSize { 'Left', 5 },
	-- },
	-- {
	--   key = 'j',
	--   mods = 'LEADER',
	--   action = act.AdjustPaneSize { 'Down', 5 },
	-- },
	-- {
	--   key = 'k',
	--   mods = 'LEADER',
	--   action = act.AdjustPaneSize { 'Up', 5 },
	-- },
	-- {
	--   key = 'l',
	--   mods = 'LEADER',
	--   action = act.AdjustPaneSize { 'Right', 5 },
	-- },
	-- -- Uppercase bindings
	-- {
	--   key = 'H',
	--   mods = 'LEADER',
	--   action = act.AdjustPaneSize { 'Left', 5 },
	-- },
	-- {
	--   key = 'J',
	--   mods = 'LEADER',
	--   action = act.AdjustPaneSize { 'Down', 5 },
	-- },
	-- {
	--   key = 'K',
	--   mods = 'LEADER',
	--   action = act.AdjustPaneSize { 'Up', 5 },
	-- },
	-- {
	--   key = 'L',
	--   mods = 'LEADER',
	--   action = act.AdjustPaneSize { 'Right', 5 },
	-- },

	{ key = "h", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "b", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "j", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "k", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "l", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Right", 5 }) },
}

-- config.color_scheme = 'AdventureTime'

config.color_scheme = "rose-pine"

-- config.color_scheme = "Dracula+"
-- config.color_scheme = "Dracula (base16)"
-- config.color_scheme = 'Batman'
-- config.color_scheme = ''
-- frond_end = "WebGpu"
-- and finally, return the configuration to wezterm
return config
