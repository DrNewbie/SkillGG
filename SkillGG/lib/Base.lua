_G.SkillGGSystem = _G.SkillGGSystem or {}

	SkillGGSystem = SkillGGSystem or {}
	SkillGGSystem.ModPath = ModPath
	SkillGGSystem.SavePath = SavePath.."SkillGGSystem.txt"
	SkillGGSystem.Mod_Ids = Idstring("Skill GG"):key()
	SkillGGSystem.SkillCD = 1 --skill cooldown
	SkillGGSystem.SkillDT = 1
	SkillGGSystem.SkillHUDPanel = nil
	SkillGGSystem.AskUseSkill = false --Tell system to run skill func
	SkillGGSystem.OggBuffer = nil
	SkillGGSystem.OggSource = nil
	
	SkillGGSystem.SkillData = {
		{
			name = "skill_gg_skill_0_name",
			desc = "skill_gg_skill_0_desc",
			bool_me = true,
		},
		{
			name = "skill_gg_skill_1_name",
			desc = "skill_gg_skill_1_desc",
			bool_me = true,
			texture = "guis/skill_gg/1_gawr_gura_A/icon01",
			cd = 10,
			func = tostring(SkillGGSystem.ModPath.."lib/skill/1_gawr_gura_a/function.lua"),
			ogg = tostring(SkillGGSystem.ModPath.."assets/sounds/ogg_aaaafdc75278f44d.ogg"),
		}
	}
	
	for i, _ in pairs(SkillGGSystem.SkillData) do
		SkillGGSystem.SkillData[i].key = Idstring(tostring(i)):key()
	end
	
	if blt.xaudio then
		blt.xaudio.setup()
	end
	
	function SkillGGSystem:PlayOgg(__ogg)
		if blt.xaudio then
			if self.OggSource then
				self.OggSource:close(true)
				self.OggSource = nil
			end
			if self.OggBuffer then
				self.OggBuffer:close(true)
				self.OggBuffer = nil
			end
			self.OggBuffer = XAudio.Buffer:new(__ogg)
			self.OggSource = XAudio.Source:new(self.OggBuffer)
		end
		return
	end
	
	function SkillGGSystem:GetSkillIcon(var)
		var = var or self:GetCurretSkill()
		local data = self:GetSkillData(var)
		if data then
			return data.texture
		else
			--??
		end
		return "guis/textures/pd2/endscreen/what_is_this"
	end
	
	function SkillGGSystem:GetSkillName(var)
		var = var or self:GetCurretSkill()
		local data = self:GetSkillData(var)
		if data then
			return data.name
		else
			--??
		end
		return "skill_gg_menu_name"
	end
	
	function SkillGGSystem:GetSkillKey(var)
		var = var or self:GetCurretSkill()
		local data = self:GetSkillData(var)
		if data then
			return data.key
		else
			--??
		end
		return "0"
	end
	
	function SkillGGSystem:GetSkillDesc(var)
		var = var or self:GetCurretSkill()
		local data = self:GetSkillData(var)
		if data then
			return data.desc
		else
			--??
		end
		return "skill_gg_none_text"
	end
	
	function SkillGGSystem:GetSkillData(var)
		var = var or self:GetCurretSkill()
		if type(self.SkillData) == "table" and self.SkillData[var] and self.SkillData[var].bool_me then
			return self.SkillData[var]
		else
			--??
		end
		return nil
	end
	
	function SkillGGSystem:SetSkillHUDPanel(panel)
		self.SkillHUDPanel = panel
		return
	end
	
	function SkillGGSystem:SetSkillHUDIcon(texture)
		if self.SkillHUDPanel and self.SkillHUDPanel:child("icon") then
			self.SkillHUDPanel:child("icon"):set_image(texture)
		end
		return
	end

	function SkillGGSystem:Default()
		return {
			skill_now = 0
		}
	end

	function SkillGGSystem:save()
		local _file = io.open(self.SavePath, "w+")
		if _file then
			_file:write(json.encode(self.Settings))
			_file:close()
		end
		return
	end

	function SkillGGSystem:reset()
		self.Settings = self:Default()
		self:save()
		return
	end

	function SkillGGSystem:load()
		self.Settings = self:Default()
		local _file = io.open(self.SavePath, "r")
		if _file then
			for k, v in pairs(json.decode(_file:read("*all")) or {}) do
				if k and self:Default()[k] and type(self:Default()[k]) == type(v) then
					self.Settings[k] = v
				end
			end
			_file:close()
		else
			self:reset()
		end
		return
	end
	
	function SkillGGSystem:SetCurretSkill(var)
		var = var or self:GetCurretSkill()
		local skill_data = self:GetSkillData(var)
		if skill_data then
			self.Settings.skill_now = var
			self.SkillCD = skill_data.cd or 1
			self:SetSkillHUDIcon(skill_data.texture)
		end
		self:save()
		return
	end
	
	function SkillGGSystem:GetCurretSkill()
		local ans = self.Settings.skill_now or 0
		return tonumber(tostring(ans))
	end

	function SkillGGSystem:SetSkillCD(var)
		self.SkillCD = var
		return
	end

	function SkillGGSystem:GetSkillCD()
		return self.SkillCD
	end

	function SkillGGSystem:SetSkillDT(var)
		self.SkillDT = var
		return
	end

	function SkillGGSystem:GetSkillDT()
		return self.SkillDT
	end

	function SkillGGSystem:AddSkillDT(var)
		self.SkillDT = math.min(self.SkillDT + var, self.SkillCD)
		return
	end

	function SkillGGSystem:GetSkillCDRatio()
		return math.clamp(self.SkillDT/self.SkillCD, 0, 1)
	end
	
	function SkillGGSystem:UseSkill()
		if self:GetCurretSkill() > 0 then
			SkillGGSystem.AskUseSkill = true
		end
		return
	end
	
	function SkillGGSystem:IsEquipped(key)
		return self:GetSkillKey() == key
	end
	
	function SkillGGSystem:GetSkillFullDesc(var)
		var = var or self:GetCurretSkill()
		local skill_data = self:GetSkillData(var)
		local __desc = managers.localization:to_upper_text("skill_gg_menu_name")
		__desc = __desc .. ": " ..	managers.localization:text(skill_data.name) .. "\n"
		__desc = __desc .. "\n" ..	managers.localization:text(skill_data.desc) .. "\n"
		__desc = __desc .. "\n" ..	managers.localization:text("skill_gg_skill_desc_cd")
		__desc = __desc .. "\n" ..	managers.localization:text("skill_gg_skill_desc_tt")
		local __cd = skill_data.cd and (tostring(skill_data.cd).."s") or "None"
		__desc = __desc:gsub("%$%$cd%$%$", __cd)		
		local __tt = skill_data.tt and (tostring(skill_data.tt).."s") or "Unlimited"
		__desc = __desc:gsub("%$%$tt%$%$", __tt)
		return __desc
	end

	SkillGGSystem:load()