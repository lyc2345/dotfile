
function CaffeinateCallback(eventType)
    if (eventType == hs.caffeinate.watcher.screensDidSleep) then
      print("ScreensDidSleep")
    elseif (eventType == hs.caffeinate.watcher.screensDidWake) then
      print("ScreensDidWake")
    elseif (eventType == hs.caffeinate.watcher.screensDidLock) then
      print("ScreensDidLock")
      DisconnectBluetooth()
    elseif (eventType == hs.caffeinate.watcher.screensDidUnlock) then
      print("ScreensDidUnlock")
      ConnectBluetooth()
    end
end

CaffeinateWatcher = hs.caffeinate.watcher.new(CaffeinateCallback)
CaffeinateWatcher:start()
