--- Audio-related stuff

local module = {}

function module.SetVolume(diff, delay)
    delay = delay or 0 -- default  value is nil
    local current = hs.audiodevice.defaultOutputDevice():volume()

    if diff > 10 then
        hs.timer.doAfter(delay, function()
            hs.audiodevice.defaultOutputDevice():setMuted(false)
            hs.audiodevice.defaultOutputDevice():setVolume(math.min(100, diff))
            hs.alert.show("Volume set to "..diff.."%")
        end)
        return
    end

     if diff < -10 then
         hs.audiodevice.defaultOutputDevice():setVolume(0)
         hs.audiodevice.defaultOutputDevice():setMuted(true)
        hs.alert.show("Volume muted")
         return
     end

     local new = math.min(100, math.max(0, math.floor(current + diff)))
     if new > 0 then
         hs.audiodevice.defaultOutputDevice():setMuted(false)
     else
         hs.audiodevice.defaultOutputDevice():setMuted(true)
     end

     hs.alert.closeAll(0.0)
     hs.alert.show("Volume set to "..new.."%")
     hs.audiodevice.defaultOutputDevice():setVolume(new)
 end


local spotify_was_playing = false


function SpotifyPause()
   print("Pausing Spotify")
   hs.spotify.pause()
end
function SpotifyPlay()
   print("Playing Spotify")
   hs.spotify.play()
end

-- Per-device watcher to detect headphones in/out
function AudioOutputDeviceEvent(data)
  print("Audio device:"..data)
  local dev_uid = data.dev_uid
  local event_name = data.event_name
  local event_scope = data.event_scope
  local event_element =data.event_element
  local auditDevice = hs.audiodevice.findDeviceByUID(dev_uid)

  -- print("Audiodevwatch args: %s, %s, %s, %s", dev_uid, event_name, event_scope, event_element)
  -- print("AudioDeviceDetect "..hs.inspect())

  if event_name == 'jack' then
    if auditDevice:jackConnected() then
      if spotify_was_playing then
        SpotifyPlay()
        SendNotification("Headphones plugged", "Spotify restarted")
      end
    else
      -- Cache current state to know whether we should resume
      -- when the headphones are connected again
      spotify_was_playing = hs.spotify.isPlaying()
      if spotify_was_playing then
        SpotifyPause()
        SendNotification("Headphones unplugged", "Spotify paused")
      end
    end
  end
end

for _, device in ipairs(hs.audiodevice.allOutputDevices()) do
   device:watcherCallback(AudioOutputDeviceEvent):watcherStart()
   print("Setting up watcher for audio device "..device:name())
end


-- Testing the new audiodevice watcher
--function AudioEvent(arg)
--   print("Audiowatch arg: s"..hs.inspect(arg))
--end
--
--
--hs.audiodevice.watcher.setCallback(AudioEvent)
--hs.audiodevice.watcher.start()


--hyper:bind({}, 'J', SetVolume(-3))
--hyper:bind({}, 'K', SetVolume(-3))
--hs.hotkey.bind(hyper, 'j', SetVolume(-3))
--hs.hotkey.bind(hyper, 'k', SetVolume(3))

return module

