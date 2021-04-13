_G.RS_DeadeteW = _G.RS_DeadeteW or {}

if not Utils or not Utils:IsInHeist() then

else
	if not RS_DeadeteW.Activating then
		SkillGGSystem:SetSkillDT(-RS_DeadeteW.Ready_Time-0.5)
		SkillGGSystem:PlayOgg()
		RS_DeadeteW.Mark_List = {}
		RS_DeadeteW.Block_SomeThing = false
		RS_DeadeteW.Block_SomeThing_Time = 0
		RS_DeadeteW.Activating = true
		RS_DeadeteW.Expire_Time = Application:time() + RS_DeadeteW.Ready_Time
		managers.hud:show_interaction_bar(0, RS_DeadeteW.Ready_Time)
	end
end
