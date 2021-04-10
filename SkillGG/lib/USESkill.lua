SkillGGSystem = SkillGGSystem or {}

if type(SkillGGSystem) == "table" and type(SkillGGSystem.ModPath) == "string" and managers.player and managers.player:local_player() and alive(managers.player:local_player()) then
	SkillGGSystem:UseSkill()
end