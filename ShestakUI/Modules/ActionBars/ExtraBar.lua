local T, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true then return end

------------------------------------------------------------------------------------------
--	Make ExtraActionBarFrame movable (use macro /click ExtraActionButton1)
------------------------------------------------------------------------------------------
local anchor = CreateFrame("Frame", "ExtraButtonAnchor", UIParent)
if C.actionbar.split_bars then
	anchor:SetPoint(C.position.extra_button[1], SplitBarLeft, C.position.extra_button[3], C.position.extra_button[4], C.position.extra_button[5])
else
	anchor:SetPoint(unpack(C.position.extra_button))
end
anchor:SetSize(53, 53)
anchor:SetFrameStrata("LOW")
RegisterStateDriver(anchor, "visibility", "[petbattle] hide; show")

ExtraActionBarFrame:SetParent(anchor)
ExtraActionBarFrame:ClearAllPoints()
ExtraActionBarFrame:SetAllPoints()
ExtraActionBarFrame.ignoreInLayout = true
ExtraAbilityContainer.SetSize = T.dummy
UIPARENT_MANAGED_FRAME_POSITIONS.ExtraAbilityContainer = nil

ZoneAbilityFrame:SetParent(anchor)
ZoneAbilityFrame:ClearAllPoints()
ZoneAbilityFrame:SetAllPoints()
ZoneAbilityFrame.ignoreInLayout = true
ZoneAbilityFrame.SpellButtonContainer:SetPoint("TOP", anchor, "TOP")

------------------------------------------------------------------------------------------
--	Skin ExtraActionBarFrame(by Zork)
------------------------------------------------------------------------------------------
local button = ExtraActionButton1
local texture = button.style
local disableTexture = function(style, texture)
	if texture then
		style:SetTexture(nil)
	end
end
button.style:SetTexture(nil)
hooksecurefunc(texture, "SetTexture", disableTexture)

button:SetSize(53, 53)

button.Count:SetFont(C.font.cooldown_timers_font, C.font.cooldown_timers_font_size, C.font.cooldown_timers_font_style)
button.Count:SetShadowOffset(C.font.cooldown_timers_font_shadow and 1 or 0, C.font.cooldown_timers_font_shadow and -1 or 0)
button.Count:SetPoint("BOTTOMRIGHT", 0, 1)
button.Count:SetJustifyH("RIGHT")

button:SetAttribute("showgrid", 1)

------------------------------------------------------------------------------------------
--	Skin ZoneAbilityFrame
------------------------------------------------------------------------------------------
local function SkinZoneAbilities()
	for button in ZoneAbilityFrame.SpellButtonContainer:EnumerateActive() do
		if not button.IsSkinned then
			button.NormalTexture:SetAlpha(0)
			button:StyleButton()
			button:SetSize(53, 53)
			button:SetTemplate("Transparent")
			if C.actionbar.classcolor_border == true then
				button:SetBackdropBorderColor(unpack(C.media.classborder_color))
			end

			button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			button.Icon:SetPoint("TOPLEFT", button, 2, -2)
			button.Icon:SetPoint("BOTTOMRIGHT", button, -2, 2)
			button.Icon:SetDrawLayer("BACKGROUND", 7)

			button.Count:SetFont(C.font.cooldown_timers_font, C.font.cooldown_timers_font_size, C.font.cooldown_timers_font_style)
			button.Count:SetShadowOffset(C.font.cooldown_timers_font_shadow and 1 or 0, C.font.cooldown_timers_font_shadow and -1 or 0)
			button.Count:SetPoint("BOTTOMRIGHT", 0, 1)
			button.Count:SetJustifyH("RIGHT")

			button.Cooldown:SetAllPoints(button.Icon)

			button.IsSkinned = true
		end
	end
end

hooksecurefunc(ZoneAbilityFrame, "UpdateDisplayedZoneAbilities", SkinZoneAbilities)
ZoneAbilityFrame.Style:SetAlpha(0)