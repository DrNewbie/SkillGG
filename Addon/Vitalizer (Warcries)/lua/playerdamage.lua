local old_func = "F_"..Idstring("Vitalizer350WarCry::ChangeMaxHP"):key()
local this_bool = "F_"..Idstring("Vitalizer350WarCry::ChangeMaxHPRefreshHUD"):key()

PlayerDamage[old_func] = PlayerDamage[old_func] or PlayerDamage._max_health

function PlayerDamage:_max_health(...)
	local __hp = self[old_func](self, ...)
	if managers.player:has_active_temporary_property("Vitalizer350WarCry") then
		__hp = __hp * 2
		if not self[this_bool] then
			self[this_bool] = true
			self:delay_damage(1, 1)
		end
	elseif self[this_bool] then
		self[this_bool] = false
		self:delay_damage(1, 1)
	end
	return __hp
end