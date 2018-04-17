local SPECID_FURY = 72 -- Fury's specialisation ID, as returned by GetInspectSpecialization

-- Calculate and return a unit's average item level using the formula described on this page:
-- http://www.wowpedia.org/API_GetAverageItemLevel
-- Should only be called after INSPECT_READY fired for the unit
function CalculateAverageItemLevel(unit)
	local totalIlvl = 0
	local mainHandEquipLoc, offHandEquipLoc
	
	for slot = INVSLOT_FIRST_EQUIPPED, INVSLOT_LAST_EQUIPPED do -- For every slot,
		if slot ~= INVSLOT_BODY and slot ~= INVSLOT_TABARD then -- If this isn't the shirt/tabard slot,
			local id = GetInventoryItemID(unit, slot) -- Get the ID of the item in this slot
			if id then -- If we have an item in this slot,
				local _, _, _, itemLevel, _, _, _, _, itemEquipLoc = GetItemInfo(id) -- Get the item's ilvl and equip location
				totalIlvl = totalIlvl + itemLevel -- Add it to the total
				
				if slot == INVSLOT_MAINHAND then -- If this is the main or off hand, store the equip location for later use
					mainHandEquipLoc = itemEquipLoc
				elseif slot == INVSLOT_OFFHAND then
					offHandEquipLoc = itemEquipLoc
				end
			end
		end
	end
	
	local numSlots
	if mainHandEquipLoc and offHandEquipLoc then -- The unit has something in both hands, set numSlots to 17
		numSlots = 17
	else -- The unit either has something in one hand or nothing in both hands
		local equippedItemLoc = mainHandEquipLoc or offHandEquipLoc
		
		local _, class = UnitClass(unit)
		local isFury = class == "WARRIOR" and GetInspectSpecialization() == SPECID_FURY
		
		-- If the user is holding a one-hand weapon, a main-hand weapon or a two-hand weapon as Fury, set numSlots to 17; otherwise set it to 16
		
		numSlots = (
			equippedItemLoc == "INVTYPE_WEAPON" or 
			equippedItemLoc == "INVTYPE_WEAPONMAINHAND" or
			(equippedItemLoc == "INVTYPE_2HWWEAPON" and isFury)
		) and 17 or 16
	end
	
	return totalIlvl / numSlots -- Return the average
end

-- Print out the arguments according to the first format string argument
function printf(formatStr, ...)
	print(formatStr:format(...))
end

local f = CreateFrame("Frame") -- Create a frame to receive events
f:SetScript("OnEvent", function(self, event, ...) -- When an event fires, call the method of the same name
	self[event](self, ...)
end)

f:RegisterEvent("INSPECT_READY") -- Fires when the inspect data we requested is ready

function f:INSPECT_READY(guid)
	local inspectUnit = self.inspectUnit
	if inspectUnit and UnitGUID(inspectUnit) == guid then -- If this is the unit we requested information for,
		self.inspectUnit = nil
		
		local avIlvl = CalculateAverageItemLevel(inspectUnit) -- Calculate the unit's average item level
		printf("%s has an average item level of %.2f!", UnitName(inspectUnit), avIlvl) -- Print this out to chat
		ClearInspectPlayer() -- Tell the game that we're done with this unit's data.
	end
end

-- Request the average item level of a unit to be calculated
local function RequestAverageItemLevel(unit)
	f.inspectUnit = unit
	NotifyInspect(unit)
	printf("Requesting item level of %s (unitID %s)...", UnitName(unit), unit)
end

local function sayHi()
	print("Hi")
end