
local hyperKey = 'F17'

-- A global variable for the Hyper Mode
Hyper = hs.hotkey.modal.new({}, hyperKey)

  -- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
local enterHyperMode = function()
  Hyper.triggered = false
  Hyper:enter()
  -- hs.alert.show("Hyper!", alertStyle, hs.screen.mainScreen())
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
-- send ESCAPE if no other keys are pressed.
local exitHyperMode = function()
  Hyper:exit()
  if not Hyper.triggered then
    -- Leave this for karabiner
    -- hs.eventtap.keyStroke({}, 'ESCAPE')
  	-- hs.alert.show("Hyper...", alertStyle, hs.screen.mainScreen())
  end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', enterHyperMode, exitHyperMode)


Hyper:bind({}, 'W', function()
  hs.alert.show("Hello World!", AlertStyle)
end)

--hyper:bind({'cmd'}, 'I', function()
--  hs.alert.show("Hello World capslock!", alertStyle)
--  --hs.eventtap.keyStroke({}, 'Capslock')
--  hs.hid.capslock.set(false)
--end)
