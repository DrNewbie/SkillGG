_G.RS_DeadeteW = _G.RS_DeadeteW or {}

Hooks:PostHook(PlayerMovement, "change_state", "F_"..Idstring("Reset:Deadeye (Warcries)"):key(), function(plym, name)	
	if name == "empty" or name == "mask_off" or name == "bleed_out" or name == "fatal" or name == "arrested" or name == "incapacitated" then
		RS_DeadeteW:Clean()
	end
end)