_G.Vitalizer350WarCry = _G.Vitalizer350WarCry or {}
_G.SkillGGSystem = _G.SkillGGSystem or {}

if not Utils or not Utils:IsInHeist() then

else
	SkillGGSystem:SetSkillDT(0)
	managers.player:add_to_temporary_property("Vitalizer350WarCry", Vitalizer350WarCry.DD, 1)
end
