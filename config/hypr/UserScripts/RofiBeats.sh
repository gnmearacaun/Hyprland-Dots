#!/bin/bash

# Directory for icons
iDIR="$HOME/.config/swaync/icons"

# Note: You can add more options below with the following format:
# ["TITLE"]="link"

# Define menu options as an associative array
declare -A menu_options=(

  ["nieuwemuziek-concertzender"]="http://streams.greenhost.nl:8080/nieuwemuziek"
  ["oudemuziek-concertzender"]="http://streams.greenhost.nl:8080/oudemuziek"
  ["barok-concertzender"]="http://streams.greenhost.nl:8080/barok"
  ["klassiek-concertzender"]="http://streams.greenhost.nl:8080/klassiek"
  ["bach-concertzender"]="http://streams.greenhost.nl:8080/bach"
  ["wereldmuziek-concertzender"]="http://streams.greenhost.nl:8080/wereldmuziek"
  ["contemp classical 📻🎶"]="http://79.111.119.111:8002/contclass"
  ["Vocal - radio caprice 🎻🎶"]="http://79.120.77.11:9063/"
  ["piano - radio caprice"]="http://79.120.77.11:8002/piano"
  ["baroque radio caprice"]="http://79.111.14.76:8000/baroque"
  ["organ radio caprice"]="http://79.120.77.11:8002/organ"
  ["chamber jazz - radio caprice"]="http://79.120.39.202:8002/chamberjazz"
  ["concertzenderLive ☕️🎶"]="http://streams.greenhost.nl:8080/concertzenderlive"
  # a few others:
# http://streams.greenhost.nl:8080/orientexpress
# http://streams.greenhost.nl:8080/live
# http://streams.greenhost.nl:8080/folkit
# http://streams.greenhost.nl:8080/radiophonics
# https://listen.radioking.com/radio/256885/stream/301510
)

# Function for displaying notifications
notification() {
  notify-send -u normal -i "$iDIR/music.png" "Playing now: $@"
}

# Main function
main() {
  choice=$(printf "%s\n" "${!menu_options[@]}" | rofi -dmenu -config ~/.config/rofi/config-rofi-Beats.rasi -i -p "")

  if [ -z "$choice" ]; then
    exit 1
  fi

  link="${menu_options[$choice]}"

  notification "$choice"
  
  # Check if the link is a playlist
  if [[ $link == *playlist* ]]; then
    mpv --shuffle --vid=no "$link"
  else
    mpv "$link"
  fi
}

# Check if an online music process is running and send a notification, otherwise run the main function
pkill -f http && notify-send -u low -i "$iDIR/music.png" "Online Music stopped" || main
