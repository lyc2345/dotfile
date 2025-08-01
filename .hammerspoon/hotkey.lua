
local hyper = { "cmd", "ctrl" }

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "Q", hs.caffeinate.systemSleep)

-- show front activated app infos
hs.hotkey.bind(
  hyper,
  ".",
  function()
    hs.alert.show(
      string.format(
        "App path: %s\nApp name: %s\nIM source id: %s",
        hs.window.focusedWindow():application():path(),
        hs.window.focusedWindow():application():name(),
        hs.keycodes.currentSourceID()
      )
    )
  end
)
