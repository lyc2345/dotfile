local audio = require("audio")

function USBDeviceEvent(data)
  -- print("USBDeviceEvent: "..hs.inspect(data))
  -- hs.alert.show("USBDeviceEvent: "..hs.inspect(data))

  local eventType = data.eventType
  local productID = data.productID
  local productName = data.productName

  if productName == "Razer Pro Click" then
    DetectRazerProClick(eventType)
    return
  end

  if productName == "BenQ beCreatus Dock DP1310" or productID == 24576 then
    DetectBenqDP1310(eventType)
    return
  end
end

function DetectRazerProClick(eventType)
  if eventType == "removed" then
    hs.alert.show("DetectRazerProClick removed")
    CloseApplication("Scroll Reverser")
  elseif eventType == "added" then
    hs.alert.show("DetectRazerProClick added")
    OpenApplication("Scroll Reverser")
  end
end

function DetectBenqDP1310(eventType)
  if eventType == "removed" then
    hs.alert.show("BENQ DP1310 removed")
    audio.SetVolume(-100)

  elseif eventType == "added" then
    hs.alert.show("BENQ DP1310 added")
    audio.SetVolume(90, 2)
  end
end


USBWatcher = hs.usb.watcher.new(USBDeviceEvent)
USBWatcher:start()

