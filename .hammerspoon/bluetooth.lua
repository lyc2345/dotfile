-- SONY MDR-1000X
local bleDeviceID = '8C-85-90-4C-BC-40'

function BluetoothSwitch(state)
  -- state: 0(off), 1(on)
  local cmd = "/usr/local/bin/blueutil --power "..(state)
  print(cmd)
  local result = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
end

function DisconnectBluetooth()
  local cmd = "/usr/local/bin/blueutil --disconnect "..(bleDeviceID)
  local result = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
end

function ConnectBluetooth()
  local cmd = "/usr/local/bin/blueutil --connect "..(bleDeviceID)
  local result = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
end
