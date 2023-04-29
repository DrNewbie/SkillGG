_G.FriedChicken430WarCry = _G.FriedChicken430WarCry or {}
FriedChicken430WarCry.ModPath = ModPath

_G.SkillGGSystem = _G.SkillGGSystem or {}
SkillGGSystem = SkillGGSystem or {}

FriedChicken430WarCry.CD = 240
FriedChicken430WarCry.DT = 240
FriedChicken430WarCry.DD = 60
FriedChicken430WarCry.TT = nil

table.insert(SkillGGSystem.SkillData, {
	name = "skill_gg_skill_430_name",
	desc = "skill_gg_skill_430_desc",
	bool_me = true,
	texture = "guis/skill_gg/430_wevegotbucketsofchicken/icon01",
	cd = FriedChicken430WarCry.CD,
	dt = FriedChicken430WarCry.DT,
	dd = FriedChicken430WarCry.DD,
	tt = FriedChicken430WarCry.TT,
	func = tostring(FriedChicken430WarCry.ModPath.."lua/USE.lua")
})

Hooks:Add("LocalizationManagerPostInit", "F_"..Idstring("FriedChicken430WarCry_LocLoad"):key(), function(loc)
	loc:load_localization_file(FriedChicken430WarCry.ModPath.."loc/en.json")
end)