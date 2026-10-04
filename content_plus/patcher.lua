local utils = require("gdpatch.utils")

function utils.replace(src, a, b)
	if not string.find(src, a, 1, true) then
		print("!PATCH FAILED!: \n\n" .. a .. "\n\n" .. b .. "\n")
		return src
	end

	src = string.gsub(src, utils.escape(a), function()
		return b
	end, 1)
	return src
end

GDPatch.patch_script_as_text("scenes/manager/round_manager/round_manager.gdc", function(_ctx, src)
	src = utils.replace(
		src,
		'const FRENZY: PackedScene = preload("uid://dw5vtdhpmgxr2")',
		[[const FRENZY: PackedScene = preload("uid://dw5vtdhpmgxr2")
@onready var MOUNTAINVPN: PackedScene = load("res://scenes/game_object/clickables/mountainvpn/mountainvpn.tscn")]]
	)

	src = utils.replace(
		src,
		"powerups.add_item(FRENZY, 3)",
		[[powerups.add_item(FRENZY, 3)
	powerups.add_item(MOUNTAINVPN, 6)]]
	)
	print("\n" .. src)
	return src
end)

GDPatch.patch_script_as_text("scenes/ui/profile_stats_menu.gdc", function(_ctx, src)
	src = utils.replace(
		src,
		'["frenzy.exe", "frenzy_files_opened", preload("res://assets/icons/damage file-export.png"), "named"], ',
		[[ ["frenzy.exe", "frenzy_files_opened", preload("res://assets/icons/damage file-export.png"), "named"],
	["mountainvpn.exe", "mountainvpn_files_opened", preload("res://assets/icons/damage file-export.png"), "named"],]]
	)

	return src
end)

GDPatch.patch_script_as_text("scenes/autoload/stat_tracker.gdc", function(_ctx, src)
	src = utils.replace(
		src,
		'"frenzy": "frenzy_files_opened", ',
		[["frenzy": "frenzy_files_opened",
	"mountainvpn": "mountainvpn_files_opened",]]
	)

	return src
end)

print("e il gioco è fatto")
