
Speecher = hs.speech.new()
Speecher:speak("Hammerspoon is online")
hs.notify.new(
  {
    title="Hammerspoon launch",
    informativeText="Boss, at your service"
  }
):send()
