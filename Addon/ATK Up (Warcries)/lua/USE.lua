_G.ATKUp340WarCry = _G.ATKUp340WarCry or {}
_G.SkillGGSystem = _G.SkillGGSystem or {}

if not Utils or not Utils:IsInHeist() then

else
	SkillGGSystem:SetSkillDT(0)
	managers.player:activate_temporary_upgrade("temporary", "overkill_damage_multiplier")
	managers.player:add_to_temporary_property("ATKUp340WarCry", ATKUp340WarCry.DD, 1)
end
