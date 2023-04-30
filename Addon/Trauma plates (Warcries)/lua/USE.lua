_G.Traumaplates410WarCry = _G.Traumaplates410WarCry or {}
_G.SkillGGSystem = _G.SkillGGSystem or {}

if not PlayerDamage or not Utils or not Utils:IsInHeist() or not SkillGGSystem then

else
	SkillGGSystem:SetSkillDT(0)
	SkillGGSystem:AddSkillTT(1)
	if managers.player:player_unit() and managers.player:player_unit():character_damage() then
		if not _G.Traumaplates410WarCry.DoFileAgain then
			_G.Traumaplates410WarCry.DoFileAgain = true
			dofile(Traumaplates410WarCry.ModPath.."lua/playerdamage.lua")
		end
		managers.player.__Traumaplates410WarCry = managers.player.__Traumaplates410WarCry or 0
		managers.player.__Traumaplates410WarCry = managers.player.__Traumaplates410WarCry + 300
		managers.player:player_unit():sound_source():post_event("bar_armor_finished")
	end
end
