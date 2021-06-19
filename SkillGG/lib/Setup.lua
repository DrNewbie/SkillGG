function Warcries:OptChanged()
	if managers.hud and managers.hud.skill_gg_update and self._hud_skill_gg and self._hud_skill_gg.__opt_bool then
		if self._hud_skill_gg.__offset_x ~= Warcries.Options:GetValue("icon_offset_x") then
			self._hud_skill_gg.__offset_x = Warcries.Options:GetValue("icon_offset_x")
			self._hud_skill_gg._panel:set_center_x( self._hud_skill_gg._hud_panel:center_x() *  self._hud_skill_gg.__offset_x)			
		end
		if self._hud_skill_gg.__offset_y ~= Warcries.Options:GetValue("icon_offset_y") then
			self._hud_skill_gg.__offset_y = Warcries.Options:GetValue("icon_offset_y")
			self._hud_skill_gg._panel:set_center_y( self._hud_skill_gg._hud_panel:center_y() *  self._hud_skill_gg.__offset_y)			
		end
		if self._hud_skill_gg.__icon_sisze ~= Warcries.Options:GetValue("icon_size") then
			self._hud_skill_gg.__icon_sisze = Warcries.Options:GetValue("icon_size")
			self._hud_skill_gg._panel:set_w(200 * self._hud_skill_gg.__icon_sisze)
			self._hud_skill_gg._panel:set_h(100 * self._hud_skill_gg.__icon_sisze)
			self._hud_skill_gg._panel:child("icon"):set_w(48 * self._hud_skill_gg.__icon_sisze)
			self._hud_skill_gg._panel:child("icon"):set_h(48 * self._hud_skill_gg.__icon_sisze)
		end
	end
end