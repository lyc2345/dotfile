-- Some useful global variables
Hostname = hs.host.localizedName()
Logger = hs.logger.new('main')
HS_CONFIG_DIR = hs.configdir

-- Display a notification
function SendNotification(title, message)
   hs.notify.new({title=title, informativeText=message}):send()
end

-- Algorithm to choose whether white/black as the most contrasting to a given
-- color, from http://gamedev.stackexchange.com/a/38561/73496
function ChooseContrastingColor(c)
   local L = 0.2126*(c.red*c.red) + 0.7152*(c.green*c.green) + 0.0722*(c.blue*c.blue)
   local black = { ["red"]=0.000,["green"]=0.000,["blue"]=0.000,["alpha"]=1 }
   local white = { ["red"]=1.000,["green"]=1.000,["blue"]=1.000,["alpha"]=1 }
   if L>0.5 then
      return black
   else
      return white
   end
end


AlertStyle = {
    strokeWidth  = 4,
    strokeColor = { white = 0.85, alpha = 0.85 },
    fillColor   = { white = 0.85, alpha = 0.85 },
    textColor = { white = 0, alpha = 0.9 },
    textFont  = ".AppleSystemUIFont",
    textSize  = 22,
    radius = 9,
}
