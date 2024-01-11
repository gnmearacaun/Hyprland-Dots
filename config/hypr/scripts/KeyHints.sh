#!/bin/bash
## /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Keyhints. Idea got from Garuda Hyprland

# Detect monitor resolution and scale
x_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
y_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .height')
hypr_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sed 's/\.//')

# Calculate width and height based on percentages and monitor resolution
width=$((x_mon * hypr_scale / 100))
height=$((y_mon * hypr_scale / 100))

# Set maximum width and height
max_width=1000
max_height=1400

# Set percentage of screen size for dynamic adjustment
percentage_width=65
percentage_height=95

# Calculate dynamic width and height
dynamic_width=$((width * percentage_width / 100))
dynamic_height=$((height * percentage_height / 100))

# Limit width and height to maximum values
dynamic_width=$(($dynamic_width > $max_width ? $max_width : $dynamic_width))
dynamic_height=$(($dynamic_height > $max_height ? $max_height : $dynamic_height))

# Launch yad with calculated width and height
yad --width=$dynamic_width --height=$dynamic_height \
	--center \
	--title="Keybindings" \
	--no-buttons \
	--list \
	--column=Key: \
	--column=Description: \
	--column=Command: \
	--timeout-indicator=bottom \
	" mouse_down" "Scroll through existing workspaces" "with mainMod + scroll" \
	" mouse:272" "Move/resize windows" "with mainMod + LMB/RMB and dragging" \
	" SHIFT 1" "movetoworkspace" "Move active window and follow to workspace" \
	" CTRL 1" "movetoworkspacesilent" "Move active window to a workspace silently" \
	" A" "screenshot region" "(swappy)" \
	" B" "Hide/UnHide Waybar" "waybar" \
	" Print" "screenshot" "(grim)" \
	" Shift Print" "screenshot region" "(grim + slurp)" \
	"ALT Print" "Screenshot active window" "active window in 10 seconds" \
	" ALT Print" "Screenshot in 10s" "" \
	" SHIFT E" "Emoji menu" "" \
	" E" "View or EDIT Keybinds, Settings, Monitor" "" \
	" Shift F" "Toggle float" "single window" \
	" CTRL F" "Toggle all windows to float" "all windows" \
	" G" "Toggle group" "whatever that means" \
	" SHIFT G" "Gamemode! All animations OFF or ON" "toggle" \
	" CTRL H" "movewindow" "Move windows" \
	" SHIFT H" "resizewindow" "Resize windows" \
	" M" "Toggle Dwindle | Master Layout" "Hyprland Layout" \
	" O " "ranger" "(window)" \
	" P" "pseudo" "dwindle" \
	"CTRL Tab" "changegroupactive" "Change focus to another window" \
	" CTRL Return" "swapwithmaster" "layoutmsg" \
	" [" "add master" "Hyprland Layout" \
	" ]" "remove master" "Hyprland Layout" \
	" CTRL R" "Reload Waybar swaync Rofi" "Check notifications first!" \
	" SHIFT S" "movetoworkspace" "Make this the special window" \
	" S" "togglespecialworkspace" "Toggle Special workspace" \
	" T" "Tunes" "music streams in Rofi menu" \
	" SHIFT W" "wallpaper menu" "select a wallpaper" \
	"CTRL ALT P" "power-menu" "(wlogout)" \
	"CTRL ALT L" "screen lock" "(swaylock)" \
	"CTRL ALT Del" "Hyprland Exit" "(SAVE YOUR WORK!!!)" \
	" X " "closes a specified window" "(window)" \
	" Y" "Choose waybar styles" "(waybar styles)" \
	" SHIFT Y" "Choose waybar layout" "(waybar layout)" \
	" V" "dispatch splitratio 0.3" "Hyprland Layout" \
	" Z" "Toggle Blur" "normal or less blur" \
