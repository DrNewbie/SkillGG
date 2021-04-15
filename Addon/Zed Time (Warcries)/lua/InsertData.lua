_G.ZedTimeWarCry = _G.ZedTimeWarCry or {}
ZedTimeWarCry.ModPath = ModPath

_G.SkillGGSystem = _G.SkillGGSystem or {}
SkillGGSystem = SkillGGSystem or {}

ZedTimeWarCry.CD = 20
ZedTimeWarCry.DD = 10
ZedTimeWarCry.TimeEffect = 	{
	sustain = ZedTimeWarCry.DD,
	timer = "pausable",
	speed = 0.25,
	fade_in = 0.25,
	fade_out = 0.8
}

table.insert(SkillGGSystem.SkillData, {
	name = "skill_gg_skill_4_name",
	desc = "skill_gg_skill_4_desc",
	bool_me = true,
	texture = "guis/skill_gg/4_zed_time/icon01",
	cd = ZedTimeWarCry.CD,
	dt = ZedTimeWarCry.DT,
	dd = ZedTimeWarCry.DD,
	func = tostring(ZedTimeWarCry.ModPath.."lua/USE.lua"),
	ogg = "ogg_7c34974335688d94"
})

Hooks:Add("LocalizationManagerPostInit", "F_"..Idstring("ZedTimeWarCry_LocLoad"):key(), function(loc)
	loc:load_localization_file(ZedTimeWarCry.ModPath.."loc/en.json")
end)