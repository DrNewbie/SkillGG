_G.FriedChicken430WarCry = _G.FriedChicken430WarCry or {}
_G.SkillGGSystem = _G.SkillGGSystem or {}

if not Utils or not Utils:IsInHeist() then

else
	SkillGGSystem:SetSkillDT(0)
	managers.player:add_to_temporary_property("FriedChicken430WarCry", FriedChicken430WarCry.DD, 1)
end
