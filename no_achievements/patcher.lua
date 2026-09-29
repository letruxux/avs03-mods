local utils = require("gdpatch.utils")

GDPatch.patch_script_as_text("scenes/autoload/steamworks.gdc", function(ctx, src)
	src = src:gsub(
		utils.escape("extends Node"),
		utils.escape(
			string.format(
				[[extends Node
      
      var achievements_enabled: bool = %s
      var stats_enabled: bool = %s]],
				tostring(not GDPatch.get_config_option(nil, "disable", "achievements")),
				tostring(not GDPatch.get_config_option(nil, "disable", "stats"))
			),
			true
		),
		1
	)

	src = src:gsub(
		utils.escape("func unlock_achievement(api_name: String) -> bool:"),
		utils.escape(
			[[func unlock_achievement(api_name: String) -> bool:
      if !achievements_enabled:
      return false]],
			true
		),
		1
	)

	src = src:gsub(
		utils.escape("func clear_achievement(api_name: String) -> bool:"),
		utils.escape(
			[[func clear_achievement(api_name: String) -> bool:
      if !achievements_enabled:
      return false]],
			true
		),
		1
	)

	src = src:gsub(
		utils.escape("func indicate_progress(api_name: String, current: int, maximum: int) -> bool:"),
		utils.escape(
			[[func indicate_progress(api_name: String, current: int, maximum: int) -> bool:
      if !achievements_enabled:
      return false]],
			true
		),
		1
	)

	src = src:gsub(
		utils.escape("func set_stat_int(stat_name: String, value: int) -> bool:"),
		utils.escape(
			[[func set_stat_int(stat_name: String, value: int) -> bool:
      if !stats_enabled:
      return false]],
			true
		),
		1
	)

	src = src:gsub(
		utils.escape("func get_stat_int(stat_name: String) -> int:"),
		utils.escape(
			[[func get_stat_int(stat_name: String) -> int:
      if !stats_enabled:
      return 0]],
			true
		),
		1
	)

	src = src:gsub(
		utils.escape("func store_stats() -> bool:"),
		utils.escape(
			[[func store_stats() -> bool:
      if !stats_enabled:
      return false]],
			true
		),
		1
	)

	print("Achievements disabled: " .. tostring(GDPatch.get_config_option(nil, "disable", "achievements")))
	print("Stats disabled: " .. tostring(GDPatch.get_config_option(nil, "disable", "stats")))

	return src
end)
