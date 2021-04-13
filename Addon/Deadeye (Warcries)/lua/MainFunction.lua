_G.RS_DeadeteW = _G.RS_DeadeteW or {}

local __Main_Deadeye_Delay = 0
local __Shot_Need_To_Do_Delay = 0

local Get_Crosshair_Enemy = function ()
	if not managers.player or not managers.player:player_unit() then
		return nil, 0
	end
	local camera = managers.player:player_unit():camera()
	local mvec_to = Vector3()
	local from_pos = camera:position()
	mvector3.set(mvec_to, camera:forward())
	mvector3.multiply(mvec_to, 20000)
	mvector3.add(mvec_to, from_pos)
	local _col_ray = World:raycast("ray", from_pos, mvec_to, "slot_mask", managers.slot:get_mask("enemies"))
	return _col_ray or nil
end

Hooks:PostHook(PlayerStandard, "update", "F_"..Idstring("Loop:Deadeye (Warcries)"):key(), function(ply, t, dt)	
	if __Main_Deadeye_Delay > t then
	
	else
		__Main_Deadeye_Delay = t + 0.05
		if RS_DeadeteW.Activating and not RS_DeadeteW.Activating_Ready_to_End_RUN then
			local delta = 0
			local _timer = RS_DeadeteW.Expire_Time - t
			delta = math.clamp(_timer / RS_DeadeteW.Ready_Time, 0, 1)
			RS_DeadeteW.Rage_Point = math.clamp((RS_DeadeteW.Rage_Point_Max * delta), 0, RS_DeadeteW.Rage_Point_Max)
			if RS_DeadeteW.Rage_Point <= 0 then
				RS_DeadeteW.Activating_Ready_to_End_RUN = true
				managers.hud:hide_interaction_bar()
				managers.hud:hide_progress_timer_bar()
			else
				if not RS_DeadeteW.Block_SomeThing then
					RS_DeadeteW.Block_SomeThing = true
					RS_DeadeteW.Block_SomeThing_Time = t + RS_DeadeteW.Ready_Time + 2
				end
				managers.hud:set_interaction_bar_width((RS_DeadeteW.Ready_Time - _timer), RS_DeadeteW.Ready_Time)
				local _col_ray = Get_Crosshair_Enemy()
				if _col_ray and _col_ray.unit and managers.enemy:is_enemy(_col_ray.unit) then
					_col_ray.unit:contour():add("mark_enemy", false)
					RS_DeadeteW.Mark_List[_col_ray.unit:key()] = {col_ray = _col_ray, t = RS_DeadeteW.Expire_Time + 1}
				end
				for _id, _data in pairs(RS_DeadeteW.Mark_List) do
					if type(_data.t) == "number" and alive(_data.col_ray.unit) then
						_data.col_ray.unit:contour():add("mark_enemy", false)
					else
						RS_DeadeteW.Mark_List[_id] =  {}
					end
				end
				RS_DeadeteW.Shot_Need_To_Do = table.size(RS_DeadeteW.Mark_List)
			end
		end
		local _real_health = ply._unit:character_damage():get_real_health()
		local weap_base = nil
		if ply._equipped_unit then
			weap_base = ply._equipped_unit:base()
		end
		if RS_DeadeteW.Activating_Ready_to_End_RUN and weap_base and RS_DeadeteW.Shot_Need_To_Do > 0 and t > __Shot_Need_To_Do_Delay then
			RS_DeadeteW.Shot_Need_To_Do = RS_DeadeteW.Shot_Need_To_Do - 1
			if _real_health > 0 then
				__Shot_Need_To_Do_Delay = t + 0.05
				local weap_tweak_data = tweak_data.weapon[weap_base:get_name_id()]
				local shake_multiplier = weap_tweak_data.shake[ply._state_data.in_steelsight and "fire_steelsight_multiplier" or "fire_multiplier"]
				ply._ext_camera:play_shaker("fire_weapon_rot", 1 * shake_multiplier)
				ply._ext_camera:play_shaker("fire_weapon_kick", 1 * shake_multiplier, 1, 0.15)
				weap_base:tweak_data_anim_play("fire", 1)
				weap_base:start_shooting()
				ply._camera_unit:base():start_shooting()
			end
			if RS_DeadeteW.Shot_Need_To_Do < 0 then
				RS_DeadeteW.Shot_Need_To_Do = 0
			end
		end
		if t > __Shot_Need_To_Do_Delay and RS_DeadeteW.Activating_Ready_to_End_RUN and table.size(RS_DeadeteW.Mark_List) > 0 and RS_DeadeteW.Prepare_To_Stop == 0 then
			if weap_base then
				for _id, _data in pairs(RS_DeadeteW.Mark_List) do
					if type(_data.t) == "number" and t > _data.t and alive(_data.col_ray.unit) and weap_base:fire_mode() == "single" then
						local hit_unit = _data.col_ray.unit
						if hit_unit:in_slot(8) and alive(hit_unit:parent()) then
							hit_unit = hit_unit:parent()
						end
						if _real_health > 0 then
							if hit_unit:character_damage() and hit_unit:character_damage().damage_simple then
								local _action_data = {}
								hit_unit:character_damage():damage_simple({
									variant = "explosion",
									damage = 1000,
									attacker_unit = ply._unit,
									pos = ply._unit:position(),
									attack_dir = ply._unit:rotation():y()
								})
							end
						end
						RS_DeadeteW.Mark_List[_id] = {}
						RS_DeadeteW.Prepare_To_Stop = t + 0.05
					end
				end
			end
		end
		if RS_DeadeteW.Block_SomeThing and t > RS_DeadeteW.Block_SomeThing_Time then
			RS_DeadeteW.Block_SomeThing = false
			RS_DeadeteW.Block_SomeThing_Time = 0
			RS_DeadeteW:Clean()
		end
	end
end)

local old_update_check_actions = PlayerStandard._update_check_actions

function PlayerStandard:_update_check_actions(...)
	if RS_DeadeteW.Block_SomeThing then
		self:_update_ground_ray()
		self:_update_fwd_ray()
		self:_update_movement(...)
		return
	end
	return old_update_check_actions(self, ...)
end

local old_get_max_walk_speed = PlayerStandard._get_max_walk_speed

function PlayerStandard:_get_max_walk_speed(...)
	local _ans = old_get_max_walk_speed(self, ...)
	return RS_DeadeteW.Block_SomeThing and _ans*0.05 or _ans
end