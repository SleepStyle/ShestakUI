local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.show_arena ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_PVPSpecIcons
----------------------------------------------------------------------------------------

local _, ns = ...
local oUF = ns.oUF or oUF

local Update = function(self, event, unit)
	if event == 'ARENA_OPPONENT_UPDATE' and unit ~= self.unit then return; end
	local specIcon = self.FactionIcon

	local _, instanceType = IsInInstance();
	specIcon.instanceType = instanceType

	if(specIcon.PreUpdate) then specIcon:PreUpdate(event) end

	if instanceType == 'pvp' then
		local faction = UnitFactionGroup(self.unit)
		if faction == "Horde" then
			specIcon.Icon:SetTexture([[Interface\Icons\INV_BannerPVP_01]])
		elseif faction == "Alliance" then
			specIcon.Icon:SetTexture([[Interface\Icons\INV_BannerPVP_02]])
		else
			specIcon.Icon:SetTexture([[INTERFACE\ICONS\INV_MISC_QUESTIONMARK]])
		end
	end

	if(specIcon.PostUpdate) then specIcon:PostUpdate(event) end
end

local Enable = function(self)
	local specIcon = self.FactionIcon
	if specIcon then
		self:RegisterEvent("ARENA_OPPONENT_UPDATE", Update, true)
		self:RegisterEvent("PLAYER_ENTERING_WORLD", Update, true)

		if not specIcon.Icon then
			specIcon.Icon = specIcon:CreateTexture(nil, "BORDER")
			specIcon.Icon:SetPoint("TOPLEFT", specIcon, 2, -2)
			specIcon.Icon:SetPoint("BOTTOMRIGHT", specIcon, -2, 2)
			specIcon.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		end
		specIcon:Show()
		return true
	end
end

local Disable = function(self)
	local specIcon = self.FactionIcon
	if specIcon then
		self:UnregisterEvent("ARENA_OPPONENT_UPDATE", Update)
		self:UnregisterEvent("PLAYER_ENTERING_WORLD", Update)
		specIcon:Hide()
	end
end

oUF:AddElement('FactionIcon', Update, Enable, Disable)