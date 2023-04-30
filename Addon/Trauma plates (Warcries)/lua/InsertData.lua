_G.Traumaplates410WarCry = _G.Traumaplates410WarCry or {}
Traumaplates410WarCry.ModPath = ModPath

_G.SkillGGSystem = _G.SkillGGSystem or {}
SkillGGSystem = SkillGGSystem or {}

Traumaplates410WarCry.CD = 60
Traumaplates410WarCry.DT = 60
Traumaplates410WarCry.DD = nil
Traumaplates410WarCry.TT = 5

table.insert(SkillGGSystem.SkillData, {
	name = "skill_gg_skill_410_name",
	desc = "skill_gg_skill_410_desc",
	bool_me = true,
	texture = "guis/skill_gg/410_morearmor/icon01",
	cd = Traumaplates410WarCry.CD,
	dt = Traumaplates410WarCry.DT,
	dd = Traumaplates410WarCry.DD,
	tt = Traumaplates410WarCry.TT,
	func = tostring(Traumaplates410WarCry.ModPath.."lua/USE.lua")
})

Hooks:Add("LocalizationManagerPostInit", "F_"..Idstring("Traumaplates410WarCry_LocLoad"):key(), function(loc)
	loc:load_localization_file(Traumaplates410WarCry.ModPath.."loc/en.json")
end)