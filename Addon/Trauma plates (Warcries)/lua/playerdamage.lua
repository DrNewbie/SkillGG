local function __alt_absorption(__attack_data)
	local __pm = managers.player
	if type(__attack_data) == "table" and type(__attack_data.damage) == "number" and type(__pm.__Traumaplates410WarCry) == "number" then
		local __dmg = __attack_data.damage
		local __damage_absorption = __pm.__Traumaplates410WarCry
		if __dmg > __damage_absorption then
			--[[
				absorbs part
			]]
			managers.player.__Traumaplates410WarCry = 0
			__attack_data.damage = __dmg - __damage_absorption
		else
			--[[
				absorbs all
			]]
			managers.player.__Traumaplates410WarCry = __damage_absorption - __dmg
			__attack_data.damage = 0
		end
	end
	return __attack_data
end

local old_damage_bullet = PlayerDamage.damage_bullet
function PlayerDamage:damage_bullet(__attack_data, ...)
	if not self:_chk_can_take_dmg() then
		return
	end
	__attack_data = __alt_absorption(__attack_data)
	return old_damage_bullet(self, __attack_data, ...)
end

local old_damage_fire_hit = PlayerDamage.damage_fire_hit
function PlayerDamage:damage_fire_hit(__attack_data, ...)
	if not self:_chk_can_take_dmg() then
		return
	end
	__attack_data = __alt_absorption(__attack_data)
	return old_damage_fire_hit(self, __attack_data, ...)
end