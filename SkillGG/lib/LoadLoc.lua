_G.SkillGGSystem = _G.SkillGGSystem or {}
SkillGGSystem = SkillGGSystem or {}

Hooks:Add("LocalizationManagerPostInit", "SkillGGSystem_LocLoad", function(loc)
	loc:load_localization_file(SkillGGSystem.ModPath.."loc/en.json")
end)