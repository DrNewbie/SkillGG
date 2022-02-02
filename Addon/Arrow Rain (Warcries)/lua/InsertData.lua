_G.ArrowRain600WarCry = _G.ArrowRain600WarCry or {}
ArrowRain600WarCry.ModPath = ModPath

_G.SkillGGSystem = _G.SkillGGSystem or {}
SkillGGSystem = SkillGGSystem or {}

ArrowRain600WarCry.CD = 20
ArrowRain600WarCry.DT = 20
ArrowRain600WarCry.DD = 30

table.insert(SkillGGSystem.SkillData, {
	name = "skill_gg_skill_600_name",
	desc = "skill_gg_skill_600_desc",
	bool_me = true,
	texture = "guis/skill_gg/600_arrow_rain/icon01",
	cd = ArrowRain600WarCry.CD,
	dt = ArrowRain600WarCry.DT,
	dd = ArrowRain600WarCry.DD,
	func = tostring(ArrowRain600WarCry.ModPath.."lua/USE.lua")
})

Hooks:Add("LocalizationManagerPostInit", "F_"..Idstring("ArrowRain600WarCry_LocLoad"):key(), function(loc)
	loc:load_localization_file(ArrowRain600WarCry.ModPath.."loc/en.json")
end)

BLTAssetManager:CreateEntry( 
	Idstring("guis/skill_gg/600_arrow_rain/icon01"), 
	Idstring("texture"), 
	ArrowRain600WarCry.ModPath.."assets/guis/skill_gg/600_arrow_rain/icon01.texture", 
	nil 
) 