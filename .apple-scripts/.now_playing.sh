#! /bin/bash
osascript <<EOD
tell application "System Events"
  set myList to (name of every process)
end tell

if myList contains "Spotify" then
  tell application "Spotify"
    if player state is stopped then
      -- set state to "Stopped"
    else
      set trackname to name of current track
      set artistname to artist of current track
      set albumname to album of current track
      if player state is playing then
        -- set state to "Playing"
        set current to artistname & " - " & trackname
        else if player state is paused then
        -- set state to "Paused"
      end if
    end if
  end tell
else
-- set output to "Spotify not running"
end if
EOD
