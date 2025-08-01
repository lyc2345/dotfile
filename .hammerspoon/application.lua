hs.application.enableSpotlightForNameSearches(true)

function GetApplication(applicationName)
  local app = hs.application.get(applicationName)
  return app
end

function OpenApplication(applicationName)
  local app = GetApplication(applicationName)
  if app and app:isRunning() then
    return
  end
  hs.alert.show("Open "..applicationName)
  hs.application.open(applicationName)
end

function CloseApplication(applicationName)
  local app = GetApplication(applicationName)
  if app and not app:isRunning() then
    return
  end
  hs.alert.show("Kill "..applicationName)
  app:kill()
end

--hs.fnutils.each({
--
--  { key=',', mod={}, app="System Preferences"},
--
--  { key='g', mod={}, app="Google Chrome"},
--  { key='g', mod={'cmd'}, app="Visual Studio Code"},
--
--  { key='d', mod={'cmd'}, app="Dictionary"},
--
--  { key='e', mod={'cmd'}, app="Finder"},
--  { key='e', mod={}, app="Safari"},
--
--  { key='p', mod={}, app="Sourcetree"},
--  { key='p', mod={'cmd'}, app="GitKraken"},
--
--  { key='r', mod={}, app="iTerm"},
--  { key='r', mod={'cmd'}, app="Terminal"},
--
--  { key='t', mod={}, app="Line"},
--  { key='t', mod={'cmd'}, app="Slack"},
--
--  { key='f', mod={'cmd'}, app="Dash"},
--
--  { key='v', mod={'cmd'}, app="VMWare Horizon Client"},
--
--  --{ key='x', mod={'cmd'}, app="Xcode"},
--
--}, function(hotkey)
--  Hyper:bind(hotkey.mod, hotkey.key, function()
--    OpenApplication(hotkey.app)
--  end)
--  end
--)