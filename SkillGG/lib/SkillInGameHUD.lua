_G.SkillGGSystem = _G.SkillGGSystem or {}
SkillGGSystem = SkillGGSystem or {}

if HUDManager and string.lower(RequiredScript) == "lib/managers/hudmanagerpd2" then
	HUDSKILLGG = HUDSKILLGG or class()
	
	function HUDSKILLGG:init(hud)
		self.__offset_x = 1.35
		self.__offset_y = 1.35
		self.__icon_sisze = 1
		if type(Warcries) == "table" and type(Warcries.Options) == "table" and type(Warcries.Options.GetValue) == "function" then
			self.__offset_x = Warcries.Options:GetValue("icon_offset_x")
			self.__offset_y = Warcries.Options:GetValue("icon_offset_y")
			self.__icon_sisze = Warcries.Options:GetValue("icon_size")
			self.__opt_bool = true
		end
		self._hud_panel = hud.panel
		self._panel = self._hud_panel:panel({
			name = "_skill_gg_panel",
			visible = true,
			w = 200 * self.__icon_sisze,
			h = 100 * self.__icon_sisze
		})
		self._panel:set_center(self._hud_panel:center())
		self._panel:set_center_x(self._hud_panel:center_x() * self.__offset_x)
		self._panel:set_center_y(self._hud_panel:center_y() * self.__offset_y)
		local __skill_gg_icon = self._panel:bitmap({
			name = "icon",
			texture = "guis/textures/pd2/endscreen/what_is_this",
			valign = "top",
			layer = 1,
			alpha = 1,
			visible = true,
			w = 48 * self.__icon_sisze,
			h = 48 * self.__icon_sisze
		})
		SkillGGSystem:SetSkillHUDPanel(self._panel)
		SkillGGSystem:SetCurretSkill()
	end

	function HUDSKILLGG:set_skill_gg_ratio(ratio)
		local this_panel = self._panel
		if not this_panel or type(this_panel) ~= "userdata" then return end
		
		local __skill_gg_icon = this_panel:child("icon")
		if not __skill_gg_icon or type(__skill_gg_icon) ~= "userdata" then return end
		
		if ratio >= 1 then
			__skill_gg_icon:set_alpha(1)
		else
			__skill_gg_icon:set_alpha(0.25)
		end
		return
	end

	function HUDManager:skill_gg_update(t, dt, ratio)
		self._hud_skill_gg:set_skill_gg_ratio(SkillGGSystem:GetSkillCDRatio())
		if self._hud_skill_gg.__opt_bool then
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

	Hooks:PostHook(HUDManager, "_setup_player_info_hud_pd2", "GG_"..Idstring("SkillGG:1:SkillHUDUpdate"):key(), function(self)
		self._hud_skill_gg = HUDSKILLGG:new(managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2))
	end)
	
elseif PlayerDamage and string.lower(RequiredScript) == "lib/units/beings/player/playerdamage" then
	Hooks:PostHook(PlayerDamage, "update", "GG_"..Idstring("SkillGG:2:SkillHUDUpdate"):key(), function(self, unit, t, dt)
		if managers.hud and managers.hud.skill_gg_update then
			SkillGGSystem:MainLoopFunctionPre(t, dt)
			SkillGGSystem:AddSkillDT(dt)
			SkillGGSystem:MainLoopFunctionPost(t, dt)
			managers.hud:skill_gg_update(t, dt)
		end
	end)	
end