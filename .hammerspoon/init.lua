--hs.console.consoleFont("FiraCode Nerd Font")

--------------------------

require("lib")
require("pkg")

require("hyper")
--require("hypercombo")
--require("hotkey")
require("application")

require("clipboard")
require("advanced_clipboard")

--require("external_monitor")

require("bluetooth")
require("audio")
require("misc.statuslets")
require("wifi")
require("usb")
-- require("speaker")
-- require("network")

---------------------------------

-- Print out more logging for me to see
require("hs.crash")
hs.crash.crashLogToNSLog = false

-- Make all our animations really fast
hs.window.animationDuration = 0.1

-- Trace all Lua code
function lineTraceHook(event, data)
    lineInfo = debug.getinfo(2, "Snl")
    print("TRACE: "..(lineInfo["short_src"] or "<unknown source>")..":"..(lineInfo["linedefined"] or "<??>"))
end
-- Uncomment the following line to enable tracing
--debug.sethook(lineTraceHook, "l")

-- Capture the hostname, so we can make this config behave differently across my Macs
hostname = hs.host.localizedName()

-- Ensure the IPC command line client is available
-- hs.ipc.cliInstall()
hs.ipc.cliInstall("/opt/homebrew/bin/") -- indicate the dest https://www.reddit.com/r/hammerspoon/comments/10v59ln/having_issues_with_hsipccliinstall/?rdt=41173


local function reloadConfig()
  hs.reload()
  hs.alert.show("Configuration reloaded!")
end


-- Simple configuration reload
Hyper:bind({}, 'R', function()
  reloadConfig()
  Hyper.triggered = true
end)


-- automatically reload config on file change
--hs.pathwatcher.new(hs_config_dir, reload_config):start()
--hs.loadSpoon("ReloadConfiguration")
--spoon.ReloadConfiguration:start()
hs.alert.show("Configuration loaded!")
