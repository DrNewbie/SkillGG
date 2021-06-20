_G.Vitalizer350WarCry = _G.Vitalizer350WarCry or {}
Vitalizer350WarCry.ModPath = ModPath

_G.SkillGGSystem = _G.SkillGGSystem or {}
SkillGGSystem = SkillGGSystem or {}

Vitalizer350WarCry.CD = 60
Vitalizer350WarCry.DT = 55
Vitalizer350WarCry.DD = 20

table.insert(SkillGGSystem.SkillData, {
	name = "skill_gg_skill_350_name",
	desc = "skill_gg_skill_350_desc",
	bool_me = true,
	texture = "guis/skill_gg/350_hp_upup/icon01",
	cd = Vitalizer350WarCry.CD,
	dt = Vitalizer350WarCry.DT,
	dd = Vitalizer350WarCry.DD,
	func = tostring(Vitalizer350WarCry.ModPath.."lua/USE.lua")
})

Hooks:Add("LocalizationManagerPostInit", "F_"..Idstring("Vitalizer350WarCry_LocLoad"):key(), function(loc)
	loc:load_localization_file(Vitalizer350WarCry.ModPath.."loc/en.json")
end)