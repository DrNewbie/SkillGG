local __pos_offset = function ()
	local ang = math.random() * 360 * math.pi
	local rad = math.random(20, 30)
	return Vector3(math.cos(ang) * rad, math.sin(ang) * rad, 0)
end

local __mvec_spread_direction = Vector3()

Hooks:PostHook(PlayerStandard, "update", "F_"..Idstring("ArrowRain600WarCry::Timer"):key(),function(self, __t, __dt, ...)
	if self._equipped_unit and self._equipped_unit:base() then
		local weap_base = self._equipped_unit:base()
		if weap_base and tostring(weap_base:weapon_tweak_data().categories[1]) == "bow" and not weap_base:out_of_ammo() then
			if managers.player:has_active_temporary_property("ArrowRain600WarCry") then
				if weap_base.clip_empty and weap_base:clip_empty() then
					
				else
					managers.player._temporary_properties:remove_property("ArrowRain600WarCry")
					SkillGGSystem:SetSkillDT(0)
					weap_base:_start_charging()
					weap_base._charge_start_t = -(weap_base:charge_max_t())
					weap_base:trigger_released(self:get_fire_weapon_position(), self:get_fire_weapon_direction(), 1, nil, 1, 1, 1)
					self.__ArrowRain600WarCryData = {
						__Pos = Utils:GetPlayerAimPos(self._unit, 2000),
						__Arrorws = ArrowRain600WarCry.DD,
						__Dt = 1.5
					}
				end
			end
		end
	end
	if type(self.__ArrowRain600WarCryData) == "table" then
		local __data = self.__ArrowRain600WarCryData
		if type(__data) == "table" and type(__data.__Dt) == "number" and type(__data.__Arrorws) == "number" then
			__data.__Dt = __data.__Dt - __dt
			if __data.__Dt <= 0 then
				__data.__Dt = 0.1
				__data.__Arrorws = __data.__Arrorws - 1
				local __Start_Pos = __data.__Pos or Vector3(0, 0, 0)
				__Start_Pos = __Start_Pos + __pos_offset() + Vector3(0, 0, 200)
				local __End_Pos = __Start_Pos + __pos_offset() - Vector3(0, 0, 200)
				mvector3.set(__mvec_spread_direction, __End_Pos - __Start_Pos)
				local projectile_type = self._projectile_type or tweak_data.blackmarket:get_projectile_name_from_index(7)
				ProjectileBase.throw_projectile(projectile_type, __Start_Pos, __mvec_spread_direction, managers.network:session():local_peer():id())
			end
			if __data.__Arrorws <= 0 then
				self.__ArrowRain600WarCryData = nil
			else
				self.__ArrowRain600WarCryData = __data
			end
		end
	end
end)