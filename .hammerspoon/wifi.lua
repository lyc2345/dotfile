
SSID_HOME = "Amo-5G"
SSID_WORK = "NBFLEX"
OLD_SSID = hs.wifi.currentNetwork()

function SSIDChangedEvent()
    NEW_SSID = hs.wifi.currentNetwork()

    if NEW_SSID == SSID_HOME and OLD_SSID ~= SSID_HOME then
        -- We just joined our home WiFi network
        hs.audiodevice.defaultOutputDevice():setVolume(25)
        hs.alert.show("At home!")
    elseif NEW_SSID ~= SSID_HOME and OLD_SSID == SSID_HOME then
        -- We just departed our home WiFi network
        hs.audiodevice.defaultOutputDevice():setVolume(0)
        hs.alert.show("Away home!")
    elseif NEW_SSID == SSID_WORK then
        -- We just joined work WiFi network
        hs.audiodevice.defaultOutputDevice():setVolume(0)
        hs.alert.show("At work!")
    end
    OLD_SSID = NEW_SSID
end

WifiWatcher = hs.wifi.watcher.new(SSIDChangedEvent)
WifiWatcher:start()
