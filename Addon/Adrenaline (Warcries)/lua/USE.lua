_G.Adrenaline390WarCry = _G.Adrenaline390WarCry or {}
_G.SkillGGSystem = _G.SkillGGSystem or {}

if not Utils or not Utils:IsInHeist() or not SkillGGSystem then

else
	SkillGGSystem:SetSkillDT(0)
	SkillGGSystem:AddSkillTT(1)
	if managers.player:player_unit() and managers.player:player_unit():character_damage() then
		managers.player:player_unit():character_damage():revive(true)
		managers.player:player_unit():sound_source():post_event("nine_lives_skill")
	end
end
