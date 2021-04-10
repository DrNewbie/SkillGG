_G.SkillGGSystem = _G.SkillGGSystem or {}
SkillGGSystem = SkillGGSystem or {}

if HUDManager and string.lower(RequiredScript) == "lib/managers/hudmanagerpd2" then
	HUDSKILLGG = HUDSKILLGG or class()
	
	function HUDSKILLGG:init(hud)
		self._hud_panel = hud.panel
		self._panel = self._hud_panel:panel({
			name = "_skill_gg_panel",
			visible = true,
			w = 200,
			h = 100
		})
		self._panel:set_center(self._hud_panel:center())
		self._panel:set_center_x(self._hud_panel:center_x() * 1.35)
		self._panel:set_center_y(self._hud_panel:center_y() * 1.35)
		local __skill_gg_icon = self._panel:bitmap({
			name = "icon",
			texture = "guis/textures/pd2/endscreen/what_is_this",
			valign = "top",
			layer = 1,
			alpha = 1,
			visible = true,
			w = 48,
			h = 48
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
	end

	Hooks:PostHook(HUDManager, "_setup_player_info_hud_pd2", "GG_"..Idstring("SkillGG:1:SkillHUDUpdate"):key(), function(self)
		self._hud_skill_gg = HUDSKILLGG:new(managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2))
	end)
	
elseif PlayerDamage and string.lower(RequiredScript) == "lib/units/beings/player/playerdamage" then
	Hooks:PostHook(PlayerDamage, "update", "GG_"..Idstring("SkillGG:2:SkillHUDUpdate"):key(), function(self, unit, t, dt)
		if managers.hud and managers.hud.skill_gg_update then
			SkillGGSystem:AddSkillDT(dt)
			managers.hud:skill_gg_update(t, dt)
			if SkillGGSystem.AskUseSkill then
				SkillGGSystem.AskUseSkill = false
				local skill_data = SkillGGSystem:GetSkillData()
				if skill_data and skill_data.func then
					dofile(tostring(skill_data.func))
				end
			end
		end
	end)	
end