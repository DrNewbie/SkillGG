_G.SkillGGSystem = _G.SkillGGSystem or {}
SkillGGSystem = SkillGGSystem or {}

local function __use_skill_gg_gawr_gura_A()
	local plm = managers.player
	local ply = plm:local_player()
	local weapon_unit = plm:equipped_weapon_unit()
	local ply_dmg = ply and ply:character_damage() or nil
	local ply_std = ply:movement() and ply:movement()._states.standard
	if ply_std and weapon_unit and ply_dmg then
		SkillGGSystem:SetSkillDT(0)
		SkillGGSystem:PlayOgg()
		local ply_pos = ply:position()
		managers.explosion:play_sound_and_effects(
			ply_pos,
			math.UP,
			1,
			CarryData.POOF_CUSTOM_PARAMS
		)
		local units = World:find_units_quick("sphere", ply_pos, 3000)
		for __key, __unit in pairs(units) do
			if __unit and alive(__unit) and __unit.character_damage and __unit:character_damage() ~= nil and __unit:character_damage().damage_fire and __unit ~= ply then
				EnvironmentFire.spawn(
					__unit:position(), 
					math.UP, 
					{
						--sound_event = "gl_explode",
						range = 75,
						curve_pow = 3,
						damage = 1,
						fire_alert_radius = 3000,
						alert_radius = 3000,
						--sound_event_burning = "burn_loop_gen",
						--sound_event_impact_duration = 3,
						player_damage = 0,
						burn_tick_period = 0.25,
						burn_duration = 3,
						effect_name = "effects/payday2/particles/explosions/molotov_grenade",
						fire_dot_data = {
							dot_trigger_chance = 100,
							dot_damage = 100,
							dot_length = 3,
							dot_trigger_max_distance = 3000,
							dot_tick_period = 0.25
						}
					}, 
					math.UP, 
					ply, 
					0, 
					1
				)
			end
		end
		ply:camera():play_redirect(Idstring("cmd_gogo"))
	end
end

__use_skill_gg_gawr_gura_A()