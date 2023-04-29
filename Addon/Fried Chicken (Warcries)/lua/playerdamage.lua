Hooks:PostHook(PlayerManager, "update", "FriedChicken430WarCryRunning", function(self, ...)
	if self:local_player() and self:has_active_temporary_property("FriedChicken430WarCry") then
		local player_unit = self:local_player()
		if alive(player_unit) and not player_unit:character_damage():need_revive() and not player_unit:character_damage():dead() then
			player_unit:character_damage():restore_health(
				player_unit:character_damage():_max_health()*math.random(1,7)*0.00003,						
				true
			)
		else
			self:remove_temporary_property("FriedChicken430WarCry")
		end
	end
end)