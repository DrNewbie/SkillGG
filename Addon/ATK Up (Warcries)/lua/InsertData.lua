_G.ATKUp340WarCry = _G.ATKUp340WarCry or {}
ATKUp340WarCry.ModPath = ModPath

_G.SkillGGSystem = _G.SkillGGSystem or {}
SkillGGSystem = SkillGGSystem or {}

ATKUp340WarCry.CD = 20
ATKUp340WarCry.DT = 20
ATKUp340WarCry.DD = 5

table.insert(SkillGGSystem.SkillData, {
	name = "skill_gg_skill_340_name",
	desc = "skill_gg_skill_340_desc",
	bool_me = true,
	texture = "guis/skill_gg/340_atk_up/icon01",
	cd = ATKUp340WarCry.CD,
	dt = ATKUp340WarCry.DT,
	dd = ATKUp340WarCry.DD,
	func = tostring(ATKUp340WarCry.ModPath.."lua/USE.lua")
})

Hooks:Add("LocalizationManagerPostInit", "F_"..Idstring("ATKUp340WarCry_LocLoad"):key(), function(loc)
	loc:load_localization_file(ATKUp340WarCry.ModPath.."loc/en.json")
end)