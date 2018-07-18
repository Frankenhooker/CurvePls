local AceGUI = LibStub("AceGUI-3.0")
local frame = AceGUI:Create("Frame")

function CreateCurveLink(m, d, y, name)
  if string.len(y) > 2 then y=y-2000 end
  IDNumber, Name = GetAchievementInfo(12110) -- Get Name so we dont have to localize by hand
  DEFAULT_CHAT_FRAME:AddMessage("\124cffffff00\124Hachievement:12110:"..string.gsub(UnitGUID("player"), '0x', '')..":1:".. m ..":".. d ..":".. y ..":4294967295:4294967295:4294967295:4294967295\124h[".. Name .."]\124h\124r")
end

function CreateKeyMasterLink(m, d, y, name)
  if string.len(y) > 2 then y=y-2000 end
  IDNumber, Name = GetAchievementInfo(11162) -- Get Name so we dont have to localize by hand
  DEFAULT_CHAT_FRAME:AddMessage("\124cffffff00\124Hachievement:11162:"..string.gsub(UnitGUID("player"), '0x', '')..":1:".. m ..":".. d ..":".. y ..":4294967295:4294967295:4294967295:4294967295\124h[".. Name .."]\124h\124r")
end

function InitFrame()
 frame:SetTitle("CurvePls AddOn UI")
 frame:SetStatusText("CurvePls Achievement Posting Menu")
 frame:SetLayout("Flow")
 local editbox1 = AceGUI:Create("EditBox")
 editbox1:SetLabel("  Day:")
 editbox1:SetWidth(40)
 editbox1:DisableButton(true)
 frame:AddChild(editbox1)
 local editbox2 = AceGUI:Create("EditBox")
 editbox2:SetLabel("Month:")
 editbox2:SetWidth(40)
 editbox2:DisableButton(true)
 frame:AddChild(editbox2)
 local editbox3 = AceGUI:Create("EditBox")
 editbox3:SetLabel("  Year:")
 editbox3:SetWidth(40)
 editbox3:DisableButton(true)
 frame:AddChild(editbox3)
 local curveButton = AceGUI:Create("Button")
 curveButton:SetText("Curve")
 curveButton:SetWidth(150)
 curveButton:SetCallback("OnClick", function(self, button, down) CreateCurveLink(editbox1:GetText(), editbox2:GetText(), editbox3:GetText(), "") end)
 frame:AddChild(curveButton)
 local keymasterButton = AceGUI:Create("Button")
 keymasterButton:SetText("Keystone Master")
 keymasterButton:SetWidth(150)
 keymasterButton:SetCallback("OnClick", function(self, button, down) CreateKeyMasterLink(editbox1:GetText(), editbox2:GetText(), editbox3:GetText(), "") end)
 frame:AddChild(keymasterButton)

 frame:Hide()
end

InitFrame();

SLASH_CURVE1 = '/curve';
function CurvePlsHandler1(msg, editbox)
if msg == 'help' then
  print("Enter /curve month,day,year for curve achievement, /key month,day,year for keystone master (For Example /curve 6,6,17). \n If no dates are given, the current date will be taken.")
 elseif msg == '' then
  local date = C_Calendar.GetDate();
  local year = date.year;
  local day = date.monthDay;
  local month = date.month;
  year = year - 2000;
  CreateCurveLink(month, day, year, Name)
  else
  local m, d, y = strsplit(",",msg)
  if string.len(y) > 2 then y=y-2000 end
  CreateCurveLink(m, d, y, Name)
 end
end
SlashCmdList["CURVE"] = CurvePlsHandler1;

SLASH_KEYMASTERPLS1 = '/key';
local function handler2(msg, editbox)
if msg == 'help' then
  print("Enter /curve month,day,year for curve achievement, /key month,day,year for keystone master (For Example /curve 6,6,17). \n If no dates are given, the current date will be taken.")
 elseif msg == '' then
  local date = C_Calendar.GetDate();
  local year = date.year;
  local day = date.monthDay;
  local month = date.month;
  year = year - 2000;
  CreateKeyMasterLink(month, day, year, Name)
  else
  local m, d, y = strsplit(",",msg)
  if string.len(y) > 2 then y=y-2000 end
  CreateKeyMasterLink(m, d, y, Name)
 end
end
SlashCmdList["KEYMASTERPLS"] = handler2;

SLASH_ANYTHINGPLS1 = '/fake';
local function handler3(msg, editbox)
if msg == 'help' or msg == '' then
print("Enter /fake achievementID,month,day,year to fake an achievement, (For Example /fake 11162,6,6,17). \n If no dates are given, the current date will be taken.")
return
end
local a, m, d, y = strsplit(",",msg)
IDNumber, Name = GetAchievementInfo(a) -- Get Name so we dont have to localize by hand
  if Name == nil then print("Invalid Achivement ID!")
  elseif string.len(msg) < 6 then
  local date = C_Calendar.GetDate();
  local year = date.year;
  local day = date.monthDay;
  local month = date.month;
  DEFAULT_CHAT_FRAME:AddMessage("\124cffffff00\124Hachievement:".. a ..":"..string.gsub(UnitGUID("player"), '0x', '')..":1:".. month ..":".. day ..":".. year-2000 ..":4294967295:4294967295:4294967295:4294967295\124h[".. Name .."]\124h\124r")
  elseif string.len(msg) > 5 then if string.len(y) > 2 then y=y-2000 end
  DEFAULT_CHAT_FRAME:AddMessage("\124cffffff00\124Hachievement:".. a ..":"..string.gsub(UnitGUID("player"), '0x', '')..":1:".. m ..":".. d ..":".. y ..":4294967295:4294967295:4294967295:4294967295\124h[".. Name .."]\124h\124r")
  else
  print("Bad Input!") -- This code is currently unreachable
 end
end
SlashCmdList["ANYTHINGPLS"] = handler3;

SLASH_CURVEPLS1 = '/curvepls';
local function handler4(msg, editbox)
  if frame:IsVisible() then
    frame:Hide()
  else
    frame:Show()
  end
end
SlashCmdList["CURVEPLS"] = handler4;
