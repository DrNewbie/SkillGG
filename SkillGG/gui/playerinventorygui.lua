require("lib/managers/menu/WalletGuiObject")
require("lib/utils/InventoryDescription")

_G.SkillGGSystem = _G.SkillGGSystem or {}
SkillGGSystem = SkillGGSystem or {}

local IS_WIN_32 = SystemInfo:platform() == Idstring("WIN32")
local NOT_WIN_32 = not IS_WIN_32
local TOP_ADJUSTMENT = NOT_WIN_32 and 50 or 55
local BOT_ADJUSTMENT = NOT_WIN_32 and 40 or 60
local join_stinger_binding = "menu_respec_tree_all"

local function select_anim(o, box, instant)
	_animate({
		box.image_object,
		box.animate_text and box.text_object
	}, 1, instant and 0 or 0.2)
end

local function unselect_anim(o, box, instant)
	_animate({
		box.image_object,
		box.animate_text and box.text_object
	}, 0.8, instant and 0 or 0.2)
end

function PlayerInventoryGui:_update_skill_gg()
	self:set_info_text(SkillGGSystem:GetSkillFullDesc())
end

function PlayerInventoryGui:previous_skill_gg()
	self:_update_skill_gg()
end

function PlayerInventoryGui:next_skill_gg()
	self:_update_skill_gg()
end

function PlayerInventoryGui:open_skill_gg_menu()
	local override_slots = {
		5,
		5
	}
	local new_node_data = {}

	table.insert(new_node_data, {
		name = "skill_gg_menu_name",
		on_create_func_name = "populate_skill_gg",
		category = "deployables",
		override_slots = override_slots,
		identifier = Idstring("skill_gg")
	})

	new_node_data.scroll_tab_anywhere = true
	new_node_data.topic_id = "skill_gg_menu_name"

	managers.menu:open_node("blackmarket_node", {
		new_node_data
	})
end

Hooks:PostHook(PlayerInventoryGui, "init", "GG_"..Idstring("SkillGG:1::PlayerInventoryGui"):key(), function(self)
	local __image = SkillGGSystem:GetSkillIcon()
	local __text = managers.localization:to_upper_text(SkillGGSystem:GetSkillName())

	local padding_x = 10
	local padding_y = 0
	local x = self._panel:w() - 500
	local y = TOP_ADJUSTMENT + tweak_data.menu.pd2_small_font_size
	local width = self._panel:w() - x
	local height = 540
	local combined_width = width - padding_x * 2
	local combined_height = height - padding_y * 3
	local box_width = combined_width / 3
	local box_height = combined_height / 4

	local skill_gg_box_data = {
		alpha = 1,
		name = "skill_gg",
		bg_blend_mode = "normal",
		w = box_width,
		h = box_height,
		unselected_text = __text,
		text = __text,
		image = __image,
		select_anim = select_anim,
		unselect_anim = unselect_anim,
		bg_color = Color.black:with_alpha(0.05),
		clbks = {
			right = false,
			left = callback(self, self, "open_skill_gg_menu"),
			up = callback(self, self, "previous_skill_gg"),
			down = callback(self, self, "next_skill_gg")
		}
	}
	
	local skill_gg_panel, skill_gg_box = self:create_box(skill_gg_box_data)
	
	skill_gg_panel:set_center_x(self._panel:center_x())
	skill_gg_panel:set_center_y(self._panel:center_y())
	
	self:_update_skill_gg()
end)

Hooks:PostHook(PlayerInventoryGui, "_update_stats", "GG_"..Idstring("SkillGG:2::PlayerInventoryGui"):key(), function(self, name)
	if name == "skill_gg" then
		self:_update_skill_gg()
	end
end)