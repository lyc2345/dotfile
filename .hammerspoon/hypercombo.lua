
local fastKeyStroke = function(modifiers, character)
  local event = require("hs.eventtap").event
  event.newKeyEvent(modifiers, string.lower(character), true):post()
  event.newKeyEvent(modifiers, string.lower(character), false):post()
end

-- hyper + keybindings

hs.fnutils.each({
  -- Movement
  { key='h', mod={}, keycode='left'},
  { key='j', mod={}, keycode='down'},
  { key='k', mod={}, keycode='up'},
  { key='l', mod={}, keycode='right'},
  { key='h', mod={'cmd'}, keycode='left'},
  { key='j', mod={'cmd'}, keycode='down'},
  { key='k', mod={'cmd'}, keycode='up'},
  { key='l', mod={'cmd'}, keycode='right'},
  { key='h', mod={'alt'}, keycode='left'},
  { key='j', mod={'alt'}, keycode='down'},
  { key='k', mod={'alt'}, keycode='up'},
  { key='l', mod={'alt'}, keycode='right'},

  -- Deletion
  { key='n', mod={}, keycode='delete'},
  { key='m', mod={}, keycode='forwarddelete'},
  { key='n', mod={'cmd'}, keycode='delete'},
  { key='n', mod={'alt'}, keycode='delete'},
  { key='m', mod={'alt'}, keycode='forwarddelete'},

}, function(hotkey)
  Hyper:bind(hotkey.mod, hotkey.key,
      function() fastKeyStroke(hotkey.mod, hotkey.keycode) end,
      nil,
      function() fastKeyStroke(hotkey.mod, hotkey.keycode) end
  )
  end
)
