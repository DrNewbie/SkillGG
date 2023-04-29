_G.Adrenaline390WarCry = _G.Adrenaline390WarCry or {}
Adrenaline390WarCry.ModPath = ModPath

_G.SkillGGSystem = _G.SkillGGSystem or {}
SkillGGSystem = SkillGGSystem or {}

Adrenaline390WarCry.CD = 5
Adrenaline390WarCry.DT = 5
Adrenaline390WarCry.DD = 0
Adrenaline390WarCry.TT = 3

table.insert(SkillGGSystem.SkillData, {
	name = "skill_gg_skill_390_name",
	desc = "skill_gg_skill_390_desc",
	bool_me = true,
	texture = "guis/skill_gg/390_getthefuckup/icon01",
	cd = Adrenaline390WarCry.CD,
	dt = Adrenaline390WarCry.DT,
	dd = Adrenaline390WarCry.DD,
	tt = Adrenaline390WarCry.TT,
	func = tostring(Adrenaline390WarCry.ModPath.."lua/USE.lua")
})

Hooks:Add("LocalizationManagerPostInit", "F_"..Idstring("Adrenaline390WarCry_LocLoad"):key(), function(loc)
	loc:load_localization_file(Adrenaline390WarCry.ModPath.."loc/en.json")
end)