Hooks:PostHook(PlayerStandard, "update", "RoFBuffUpdateLoop",function(self, ...)
	if self._equipped_unit and self._equipped_unit:base() then
		local weap_base = self._equipped_unit:base()
		if weap_base.__ATKUp340WarCryInit then
			if weap_base.__ATKUp340WarCryInit == 1 then
				weap_base.__ATKUp340WarCryInit = 2
				if not weap_base.__ATKUp340WarCryOldDmg then
					weap_base.__ATKUp340WarCryOldDmg = weap_base.get_damage_falloff
					local function new_dmg_func(self, damage, ...)
						if managers.player:has_active_temporary_property("ATKUp340WarCry") then
							return self:__ATKUp340WarCryOldDmg(damage*2, ...)
						end
						return self:__ATKUp340WarCryOldDmg(damage, ...)
					end
					weap_base.get_damage_falloff = new_dmg_func
				end
			end
		end
	end
end)