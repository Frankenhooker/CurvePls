local CurvePls = LibStub("AceAddon-3.0"):NewAddon("CurvePls", "AceConsole-3.0")
local AceGUI = LibStub("AceGUI-3.0")

local frame = AceGUI:Create("Frame")
local currentCurveId = 14068;

function CurvePls:OnInitialize()
    self:Print("Loaded.")

    self:RegisterChatCommand("curve", HandleCurve)
    self:RegisterChatCommand("key", HandleKey)
    self:RegisterChatCommand("fake", HandleFake)
    self:RegisterChatCommand("curvepls", HandleGui)

    InitFrame();
end

function CreateCurveLink(m, d, y, name)
    if string.len(y) > 2 then
        y = y - 2000
    end
    IDNumber, Name = GetAchievementInfo(currentCurveId) -- Get Name so we dont have to localize by hand
    if GetLocale == "enUS" then
        CurvePls:Print("\124cffffff00\124Hachievement:" .. currentCurveId .. ":"
                .. string.gsub(UnitGUID("player"), '0x', '') .. ":1:" .. m .. ":" .. d .. ":" .. y .. ":4294967295:4294967295:4294967295:4294967295\124h[" .. Name .. "]\124h\124r")
    else
        CurvePls:Print("\124cffffff00\124Hachievement:" .. currentCurveId .. ":"
                .. string.gsub(UnitGUID("player"), '0x', '') .. ":1:" .. d .. ":" .. m .. ":" .. y .. ":4294967295:4294967295:4294967295:4294967295\124h[" .. Name .. "]\124h\124r")
    end
end

function CreateKeyMasterLink(m, d, y, name)
    if string.len(y) > 2 then
        y = y - 2000
    end
    IDNumber, Name = GetAchievementInfo(11162) -- Get Name so we dont have to localize by hand
    if GetLocale == "enUS" then
        CurvePls:Print("\124cffffff00\124Hachievement:11162:"
                .. string.gsub(UnitGUID("player"), '0x', '') .. ":1:" .. m .. ":" .. d .. ":" .. y .. ":4294967295:4294967295:4294967295:4294967295\124h[" .. Name .. "]\124h\124r")
    else
        CurvePls:Print("\124cffffff00\124Hachievement:11162:"
                .. string.gsub(UnitGUID("player"), '0x', '') .. ":1:" .. d .. ":" .. m .. ":" .. y .. ":4294967295:4294967295:4294967295:4294967295\124h[" .. Name .. "]\124h\124r")
    end
end

function InitFrame()
    local date = C_Calendar.GetDate();
    local year = date.year;
    local day = date.monthDay;
    local month = date.month;

    frame:SetTitle("CurvePls AddOn UI")
    frame:SetStatusText("CurvePls Achievement Posting Menu")
    frame:SetLayout("Flow")

    local editbox1 = AceGUI:Create("EditBox")
    editbox1:SetLabel("  Day:")
    editbox1:SetWidth(40)
    editbox1:SetText(day)
    editbox1:DisableButton(true)
    frame:AddChild(editbox1)

    local editbox2 = AceGUI:Create("EditBox")
    editbox2:SetLabel("Month:")
    editbox2:SetWidth(40)
    editbox2:SetText(month)
    editbox2:DisableButton(true)
    frame:AddChild(editbox2)

    local editbox3 = AceGUI:Create("EditBox")
    editbox3:SetLabel("  Year:")
    editbox3:SetWidth(40)
    editbox3:SetText(year)
    editbox3:DisableButton(true)
    frame:AddChild(editbox3)

    local curveButton = AceGUI:Create("Button")
    curveButton:SetText("Curve")
    curveButton:SetWidth(150)
    curveButton:SetCallback("OnClick", function(self, button, down)
        CreateCurveLink(editbox1:GetText(), editbox2:GetText(), editbox3:GetText(), "")
    end)
    frame:AddChild(curveButton)

    local keymasterButton = AceGUI:Create("Button")
    keymasterButton:SetText("Keystone Master")
    keymasterButton:SetWidth(150)
    keymasterButton:SetCallback("OnClick", function(self, button, down)
        CreateKeyMasterLink(editbox1:GetText(), editbox2:GetText(), editbox3:GetText(), "")
    end)
    frame:AddChild(keymasterButton)

    frame:Hide()
end

function HandleCurve(msg, editbox)
    if msg == 'help' then
        CurvePls:Print("Enter /curve month,day,year for curve achievement, /key month,day,year for keystone master (For Example /curve 6,6,17). \n If no dates are given, the current date will be taken.")
    elseif msg == '' then
        local date = C_Calendar.GetDate();
        local year = date.year;
        local day = date.monthDay;
        local month = date.month;
        year = year - 2000;
        CreateCurveLink(month, day, year, Name)
    else
        local m, d, y = strsplit(",", msg)

        if string.len(y) > 2 then
            y = y - 2000
        end

        CreateCurveLink(m, d, y, Name)
    end
end

function HandleKey(msg, editbox)
    if msg == 'help' then
        CurvePls:Print("Enter /curve month,day,year for curve achievement, /key month,day,year for keystone master (For Example /curve 6,6,17). \n If no dates are given, the current date will be taken.")
    elseif msg == '' then
        local date = C_Calendar.GetDate();
        local year = date.year;
        local day = date.monthDay;
        local month = date.month;
        year = year - 2000;
        CreateKeyMasterLink(month, day, year, Name)
    else
        local m, d, y = strsplit(",", msg)

        if string.len(y) > 2 then
            y = y - 2000
        end

        CreateKeyMasterLink(m, d, y, Name)
    end
end

function HandleFake(msg, editbox)
    if msg == 'help' or msg == '' then
        print("Enter /fake achievementID,month,day,year to fake an achievement, (For Example /fake 11162,6,6,17). \n If no dates are given, the current date will be taken.")
        return
    end

    local achievement, m, d, y = strsplit(",", msg)
    IDNumber, Name = GetAchievementInfo(achievement) -- Get Name so we dont have to localize by hand
    if Name == nil then
        CurvePls:Print("Invalid Achivement ID!")
    elseif string.len(msg) < 6 then
        local date = C_Calendar.GetDate();
        local CurrYear = date.year;
        local CurrDay = date.monthDay;
        local CurrMonth = date.month;
        CurvePls:Print("\124cffffff00\124Hachievement:" .. achievement .. ":"
                .. string.gsub(UnitGUID("player"), '0x', '') .. ":1:" .. CurrMonth .. ":" .. CurrDay .. ":" .. CurrYear - 2000 .. ":4294967295:4294967295:4294967295:4294967295\124h[" .. Name .. "]\124h\124r")
    elseif string.len(msg) > 5 then
        if string.len(y) > 2 then
            y = y - 2000
        end

        CurvePls:Print("\124cffffff00\124Hachievement:" .. achievement .. ":"
                .. string.gsub(UnitGUID("player"), '0x', '') .. ":1:" .. m .. ":" .. d .. ":" .. y .. ":4294967295:4294967295:4294967295:4294967295\124h[" .. Name .. "]\124h\124r")
    else
        print("Bad Input!") -- This code is currently unreachable
    end
end

function HandleGui(msg, editbox)
    if frame:IsVisible() then
        frame:Hide()
    else
        frame:Show()
    end
end
