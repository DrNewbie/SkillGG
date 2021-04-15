_G.RS_DeadeteW = _G.RS_DeadeteW or {}
RS_DeadeteW.ModPath = ModPath

_G.SkillGGSystem = _G.SkillGGSystem or {}
SkillGGSystem = SkillGGSystem or {}

function RS_DeadeteW:Clean()
	self.Rage_Point = 0
	self.Rage_Point_Max = 100
	self.Ready_Time = 10
	self.Activating = false
	self.Rage_Stop = false
	self.Activating_Ready_to_End_RUN = false
	self.Activating_Ready_to_End = 0
	self.Expire_Time = 0
	self.Mark_List = {}
	self.Prepare_To_Stop = 0
	self.Shot_Need_To_Do = 0
	self.Block_SomeThing = false
	self.Block_SomeThing_Time = 0
	if managers.hud and managers.hud.hide_interaction_bar and managers.hud.hide_progress_timer_bar then
		managers.hud:hide_interaction_bar()
		managers.hud:hide_progress_timer_bar()
	end
	return
end

table.insert(SkillGGSystem.SkillData, {
	name = "skill_gg_skill_3_name",
	desc = "skill_gg_skill_3_desc",
	bool_me = true,
	texture = "guis/skill_gg/3_high_noon/icon01",
	cd = 30,
	func = tostring(RS_DeadeteW.ModPath.."lua/USE.lua"),
	ogg = "ogg_7c34974335688d94",
})

Hooks:Add("LocalizationManagerPostInit", "F_"..Idstring("RS_DeadeteW_Deadeye_LocLoad"):key(), function(loc)
	loc:load_localization_file(RS_DeadeteW.ModPath.."loc/en.json")
end)

RS_DeadeteW:Clean()