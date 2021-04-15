_G.ZedTimeWarCry = _G.ZedTimeWarCry or {}
_G.SkillGGSystem = _G.SkillGGSystem or {}

if not Utils or not Utils:IsInHeist() then

else
	SkillGGSystem:SetSkillDT(-ZedTimeWarCry.DD)
	SkillGGSystem:PlayOgg()
	managers.time_speed:play_effect("underdog_zed_time", ZedTimeWarCry.TimeEffect)
end
