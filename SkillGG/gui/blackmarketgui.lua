require("lib/managers/menu/WalletGuiObject")
require("lib/utils/InventoryDescription")
require("lib/utils/accelbyte/TelemetryConst")
require("lib/managers/menu/ExtendedPanel")
require("lib/utils/gui/FineText")
require("lib/managers/menu/UiPlacer")

_G.SkillGGSystem = _G.SkillGGSystem or {}
SkillGGSystem = SkillGGSystem or {}

function BlackMarketGui:lo_equip_skill_gg_callback(data)
	SkillGGSystem:SetCurretSkill(data.slot)	
	self:reload()
end

function BlackMarketGui:lo_unequip_skill_gg_callback(data)
	SkillGGSystem:SetCurretSkill(0)
	self:reload()
end

Hooks:PostHook(BlackMarketGui, "update_info_text", "GG_"..Idstring("SkillGG:2::BlackMarketGui"):key(), function(self, ...)
	local slot_data = self._slot_data
	local tab_data = self._tabs[self._selected]._data
	local prev_data = tab_data.prev_node_data
	local ids_category = Idstring(slot_data.category)
	local identifier = tab_data.identifier
	local updated_texts = {
		{
			text = ""
		},
		{
			text = ""
		},
		{
			text = ""
		},
		{
			text = ""
		},
		{
			text = ""
		}
	}
	if identifier == Idstring("skill_gg") then
		self._stats_text_modslist:set_text("")
		updated_texts[1].text = SkillGGSystem:GetSkillFullDesc(slot_data.slot)
		for id, _ in ipairs(self._info_texts) do
			self:set_info_text(id, updated_texts[id].text, nil)
		end
		local _, _, _, th = self._info_texts[1]:text_rect()

		self._info_texts[1]:set_h(th)

		local y = self._info_texts[1]:bottom()
		local title_offset = y
		local bg = self._info_texts_bg[1]

		if alive(bg) then
			bg:set_shape(self._info_texts[1]:shape())
		end

		local below_y = nil

		for i = 2, #self._info_texts do
			local info_text = self._info_texts[i]

			info_text:set_font_size(small_font_size)
			info_text:set_w(self._info_texts_panel:w())

			_, _, _, th = info_text:text_rect()

			info_text:set_y(y)
			info_text:set_h(th)

			local bg = self._info_texts_bg[i]

			if alive(bg) then
				bg:set_shape(info_text:shape())
			end

			y = info_text:bottom()
		end
	end
end)

Hooks:PostHook(BlackMarketGui, "_setup", "GG_"..Idstring("SkillGG:1::BlackMarketGui"):key(), function(self, ...)
	local sgg_lo_d_equip = {
		prio = 1,
		btn = "BTN_A",
		pc_btn = nil,
		name = "bm_menu_btn_equip_skill_gg",
		callback = callback(self, self, "lo_equip_skill_gg_callback")
	}
	local sgg_lo_d_unequip = {
		prio = 1,
		btn = "BTN_A",
		pc_btn = nil,
		name = "bm_menu_btn_unequip_skill_gg",
		callback = callback(self, self, "lo_unequip_skill_gg_callback")
	}
	if not self._btns["sgg_lo_d_equip"] then
		self._btns["sgg_lo_d_equip"] = BlackMarketGuiButtonItem:new(self._buttons, sgg_lo_d_equip, 10)
	end
	if not self._btns["sgg_lo_d_unequip"] then
		self._btns["sgg_lo_d_unequip"] = BlackMarketGuiButtonItem:new(self._buttons, sgg_lo_d_unequip, 10)
	end
end)

function BlackMarketGui:populate_skill_gg(data)
	local new_data = {}
	local sort_data = SkillGGSystem.SkillData
	local max_items = math.ceil(#sort_data / (data.override_slots[1] or 3)) * (data.override_slots[1] or 3)

	for i = 1, max_items do
		data[i] = nil
	end

	local index = 0

	for i, xdata in pairs(sort_data) do
		new_data = {
			name = xdata.name
		}
		new_data.name_localized = managers.localization:text(xdata.name)
		new_data.category = "skill_gg"
		new_data.bitmap_texture = xdata.texture
		new_data.slot = i
		new_data.unlocked = true
		new_data.level = 0
		new_data.equipped = SkillGGSystem:IsEquipped(xdata.key)

		if new_data.unlocked and not new_data.equipped then
			table.insert(new_data, "sgg_lo_d_equip")
		end

		if new_data.unlocked and new_data.equipped then
			table.insert(new_data, "sgg_lo_d_unequip")
		end

		data[i] = new_data
		index = i
	end

	for i = 1, max_items do
		if not data[i] then
			new_data = {
				name = "empty",
				name_localized = "",
				category = "skill_gg",
				slot = i,
				unlocked = true,
				equipped = false
			}
			data[i] = new_data
		end
	end
end