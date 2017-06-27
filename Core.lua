SLASH_CURVEPLS1= '/curve';
local function handler(msg, editbox)
if msg == 'help' then
  print("Enter /curve month,day,year for curve achievement, /key month,day,year for keystone master (For Example /curve 6,6,17). \n If no dates are given, the current date will be taken.")
 elseif msg == '' then
  weekday, month, day, year = CalendarGetDate();
  DEFAULT_CHAT_FRAME:AddMessage("\124cffffff00\124Hachievement:11874:"..string.gsub(UnitGUID("player"), '0x', '')..":1:".. month ..":".. day ..":".. year-2000 ..":4294967295:4294967295:4294967295:4294967295\124h[Ahead of the Curve: Kil'jaeden]\124h\124r")
  else
  local m, d, y = strsplit(",",msg)
  if string.len(y) > 2 then y=y-2000 end
  DEFAULT_CHAT_FRAME:AddMessage("\124cffffff00\124Hachievement:11874:"..string.gsub(UnitGUID("player"), '0x', '')..":1:".. m ..":".. d ..":".. y ..":4294967295:4294967295:4294967295:4294967295\124h[Ahead of the Curve: Kil'jaeden]\124h\124r")
 end
end
SlashCmdList["CURVEPLS"] = handler;

SLASH_KEYMASTERPLS1= '/key';
local function handler2(msg, editbox)
if msg == 'help' then
  print("Enter /curve month,day,year for curve achievement, /key month,day,year for keystone master (For Example /curve 6,6,17). \n If no dates are given, the current date will be taken.")
 elseif msg == '' then
  weekday, month, day, year = CalendarGetDate();
  DEFAULT_CHAT_FRAME:AddMessage("\124cffffff00\124Hachievement:11162:"..string.gsub(UnitGUID("player"), '0x', '')..":1:".. month ..":".. day ..":".. year-2000 ..":4294967295:4294967295:4294967295:4294967295\124h[Keystone Master]\124h\124r")
  else
  local m, d, y = strsplit(",",msg)
  if string.len(y) > 2 then y=y-2000 end
  DEFAULT_CHAT_FRAME:AddMessage("\124cffffff00\124Hachievement:11162:"..string.gsub(UnitGUID("player"), '0x', '')..":1:".. m ..":".. d ..":".. y ..":4294967295:4294967295:4294967295:4294967295\124h[Keystone Master]\124h\124r")
 end
end
SlashCmdList["KEYMASTERPLS"] = handler2;

SLASH_ANYTHINGPLS1= '/fake';
local function handler3(msg, editbox)
local a, m, d, y = strsplit(",",msg)
IDNumber, Name = GetAchievementInfo(a)
  if Name == nil then print("Invalid Achivement ID!")
  elseif msg == 'help' then
  print("Enter /fake achievementID,month,day,year to fake an achievement, (For Example /fake 11162,6,6,17). \n If no dates are given, the current date will be taken.")
  elseif string.len(msg) < 6 then
  weekday, month, day, year = CalendarGetDate();
  DEFAULT_CHAT_FRAME:AddMessage("\124cffffff00\124Hachievement:".. a ..":"..string.gsub(UnitGUID("player"), '0x', '')..":1:".. month ..":".. day ..":".. year-2000 ..":4294967295:4294967295:4294967295:4294967295\124h[".. Name .."]\124h\124r")
  elseif string.len(msg) > 5 then if string.len(y) > 2 then y=y-2000 end
  DEFAULT_CHAT_FRAME:AddMessage("\124cffffff00\124Hachievement:".. a ..":"..string.gsub(UnitGUID("player"), '0x', '')..":1:".. m ..":".. d ..":".. y ..":4294967295:4294967295:4294967295:4294967295\124h[".. Name .."]\124h\124r")
  else
  print("Bad Input!")
 end
end
SlashCmdList["ANYTHINGPLS"] = handler3;