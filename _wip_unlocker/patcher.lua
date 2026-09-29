local utils = require("gdpatch.utils")

--[[ CURSOR, 
	WEAPON, 
	PLUGIN, 
	UPGRADE, 
	PROTOCOL, 
	WIDGET, 
	SKULL, 
	GENERAL, 
	DRIVER, 
	AVATAR, 
	WALLPAPER, 
	THEME, 
	SAFE_FILE, 
	BATTLE_FILE, 
	BOSS ]]

GDPatch.patch_script_as_text("scenes/autoload/unlock_manager.gdc", function(ctx, src)
	src = src:gsub(
		utils.escape("func is_content_unlocked(category: UnlockDefinition.Category, target_id: String) -> bool:"),
		utils.escape(
			[[func is_content_unlocked(category: UnlockDefinition.Category, target_id: String) -> bool:
	#themes
	#cursors
	#weapons
	#plugins
	#upgrades
	#protocols
	#widgets
	#skulls
	#general
	#drivers
	#avatars
	#wallpapers
	#themes
	#safe_files
	#battle_files
	#bosses
]],
			true
		),
		1
	)

	if GDPatch.get_config_option(nil, "unlocks", "themes") == true then
		src = src:gsub(
			utils.escape("#themes"),
			utils.escape(
				[[if category == UnlockDefinition.Category.THEME:
		return true]],
				true
			),
			1
		)
	end

	if GDPatch.get_config_option(nil, "unlocks", "cursors") == true then
		src = src:gsub(
			utils.escape("#cursors"),
			utils.escape(
				[[if category == UnlockDefinition.Category.CURSOR:
		return true]],
				true
			),
			1
		)
	end

	if GDPatch.get_config_option(nil, "unlocks", "weapons") == true then
		src = src:gsub(
			utils.escape("#weapons"),
			utils.escape(
				[[if category == UnlockDefinition.Category.WEAPON:
		return true]],
				true
			),
			1
		)
	end

	if GDPatch.get_config_option(nil, "unlocks", "plugins") == true then
		src = src:gsub(
			utils.escape("#plugins"),
			utils.escape(
				[[if category == UnlockDefinition.Category.PLUGIN:
		return true]],
				true
			),
			1
		)
	end

	if GDPatch.get_config_option(nil, "unlocks", "upgrades") == true then
		src = src:gsub(
			utils.escape("#upgrades"),
			utils.escape(
				[[if category == UnlockDefinition.Category.UPGRADE:
		return true]],
				true
			),
			1
		)
	end

	if GDPatch.get_config_option(nil, "unlocks", "protocols") == true then
		src = src:gsub(
			utils.escape("#protocols"),
			utils.escape(
				[[if category == UnlockDefinition.Category.PROTOCOL:
		return true]],
				true
			),
			1
		)
	end

	if GDPatch.get_config_option(nil, "unlocks", "widgets") == true then
		src = src:gsub(
			utils.escape("#widgets"),
			utils.escape(
				[[if category == UnlockDefinition.Category.WIDGET:
		return true]],
				true
			),
			1
		)
	end

	if GDPatch.get_config_option(nil, "unlocks", "skulls") == true then
		src = src:gsub(
			utils.escape("#skulls"),
			utils.escape(
				[[if category == UnlockDefinition.Category.SKULL:
		return true]],
				true
			),
			1
		)
	end

	if GDPatch.get_config_option(nil, "unlocks", "general") == true then
		src = src:gsub(
			utils.escape("#general"),
			utils.escape(
				[[if category == UnlockDefinition.Category.GENERAL:
		return true]],
				true
			),
			1
		)
	end

	if GDPatch.get_config_option(nil, "unlocks", "drivers") == true then
		src = src:gsub(
			utils.escape("#drivers"),
			utils.escape(
				[[if category == UnlockDefinition.Category.DRIVER:
		return true]],
				true
			),
			1
		)
	end

	if GDPatch.get_config_option(nil, "unlocks", "avatars") == true then
		src = src:gsub(
			utils.escape("#avatars"),
			utils.escape(
				[[if category == UnlockDefinition.Category.AVATAR:
		return true]],
				true
			),
			1
		)
	end

	if GDPatch.get_config_option(nil, "unlocks", "wallpapers") == true then
		src = src:gsub(
			utils.escape("#wallpapers"),
			utils.escape(
				[[if category == UnlockDefinition.Category.WALLPAPER:
		return true]],
				true
			),
			1
		)
	end

	if GDPatch.get_config_option(nil, "unlocks", "safe_files") == true then
		src = src:gsub(
			utils.escape("#safe_files"),
			utils.escape(
				[[if category == UnlockDefinition.Category.SAFE_FILE:
		return true]],
				true
			),
			1
		)
	end

	if GDPatch.get_config_option(nil, "unlocks", "battle_files") == true then
		src = src:gsub(
			utils.escape("#battle_files"),
			utils.escape(
				[[if category == UnlockDefinition.Category.BATTLE_FILE:
		return true]],
				true
			),
			1
		)
	end

	if GDPatch.get_config_option(nil, "unlocks", "bosses") == true then
		src = src:gsub(
			utils.escape("#bosses"),
			utils.escape(
				[[if category == UnlockDefinition.Category.BOSS:
		return true]],
				true
			),
			1
		)
	end

	return src
end)
