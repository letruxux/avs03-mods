local utils = require("gdpatch.utils")

GDPatch.patch_script_as_text("scenes/autoload/appearance_manager.gdc", function(ctx, src)
	local replacement = [[var theme_manifest: ManifestResource = load(THEMES_MANIFEST) as ManifestResource
	if theme_manifest != null:
		var custom_themes_loaded := 0
		var dir := DirAccess.open("res://resources/themes")
		if dir == null:
			printerr("[ThemesLib] Could not load themes")
		else:
			print("[ThemesLib] Loading custom themes...")
			dir.list_dir_begin()
			for file: String in dir.get_files():
				if (file.begins_with("themeslib_")):
					var resource := load(dir.get_current_dir() + "/" + file)
					theme_manifest.items.append(resource)
					print("[ThemesLib] Loaded custom theme \"%s\"" % resource.id)
					custom_themes_loaded += 1
			print("[ThemesLib] Loaded %d custom themes" % custom_themes_loaded)
]]

	src = src:gsub(
		utils.escape([[var theme_manifest: ManifestResource = load(THEMES_MANIFEST) as ManifestResource
	if theme_manifest != null:]]),
		function()
			return replacement
		end,
		1
	)
	return src
end)
