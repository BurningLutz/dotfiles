#!/usr/bin/env fish

set n $argv[1]

set app_name  (yabai -m query --windows --window | jq ".app")
set window_id (yabai -m query --windows | jq "map(select (.app == $app_name)) | sort_by(.id) | .[$n].id")

yabai -m window --focus $window_id
