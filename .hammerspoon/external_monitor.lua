
-- Move the application to Window
function MoveWindowToDisplay(d)
	return function()
	  local displays = hs.screen.allScreens()
	  local win = hs.window.focusedWindow()
	  win:moveToScreen(displays[d], false, true)
	end
end

hs.fnutils.each({
  { key='1', no=1},
  { key='2', no=2},
  { key='3', no=3},
  { key='4', no=4},
  { key='5', no=5},
}, function(display)
  Hyper:bind({}, display.key, MoveWindowToDisplay(display.no))
end)