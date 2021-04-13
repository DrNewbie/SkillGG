_G.SkillGGSystem = _G.SkillGGSystem or {}
SkillGGSystem = SkillGGSystem or {}

local function __use_skill_gg_overloading_mode()
	SkillGGSystem:SetSkillDT(0)
	SkillGGSystem:PlayOgg()
	managers.player:add_to_temporary_property("bullet_storm", 10, 1)
end

__use_skill_gg_overloading_mode()