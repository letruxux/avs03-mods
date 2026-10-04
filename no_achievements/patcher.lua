local utils = require("gdpatch.utils")

local function patch_steamworks(src)
	src = src:gsub(
		utils.escape("func unlock_achievement(api_name: String) -> bool:"),
		utils.escape(
			[[func unlock_achievement(api_name: String) -> bool:
	if GDPatch.get_config_option("no_achievements, "disable", "achievements"):
		return false]],
			true
		),
		1
	)

	src = src:gsub(
		utils.escape("func clear_achievement(api_name: String) -> bool:"),
		utils.escape(
			[[func clear_achievement(api_name: String) -> bool:
	if GDPatch.get_config_option("no_achievements, "disable", "achievements"):
		return false]],
			true
		),
		1
	)

	src = src:gsub(
		utils.escape("func indicate_progress(api_name: String, current: int, maximum: int) -> bool:"),
		utils.escape(
			[[func indicate_progress(api_name: String, current: int, maximum: int) -> bool:
	if GDPatch.get_config_option("no_achievements, "disable", "achievements"):
		return false]],
			true
		),
		1
	)

	src = src:gsub(
		utils.escape("func set_stat_int(stat_name: String, value: int) -> bool:"),
		utils.escape(
			[[func set_stat_int(stat_name: String, value: int) -> bool:
	if GDPatch.get_config_option("no_achievements, "disable", "stats"):
		return false]],
			true
		),
		1
	)

	src = src:gsub(
		utils.escape("func get_stat_int(stat_name: String) -> int:"),
		utils.escape(
			[[func get_stat_int(stat_name: String) -> int:
	if GDPatch.get_config_option("no_achievements, "disable", "stats"):
		return 0]],
			true
		),
		1
	)

	src = src:gsub(
		utils.escape("func store_stats() -> bool:"),
		utils.escape(
			[[func store_stats() -> bool:
	if GDPatch.get_config_option("no_achievements, "disable", "stats"):
		return false]],
			true
		),
		1
	)

	return src
end

GDPatch.patch_script_as_text("scenes/autoload/steamworks.gdc", function(ctx, src)
	src = patch_steamworks(src)

	print("Achievements disabled: " .. tostring(GDPatch.get_config_option(nil, "disable", "achievements")))
	print("Stats disabled: " .. tostring(GDPatch.get_config_option(nil, "disable", "stats")))

	return src
end)
