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

local function patch_themes(src)
	src = utils.replace(
		src,
		[[var theme_manifest: ManifestResource = load(THEMES_MANIFEST) as ManifestResource
	if theme_manifest != null:]],
		[[var theme_manifest: ManifestResource = load(THEMES_MANIFEST) as ManifestResource
	if theme_manifest != null:
		var custom_themes_loaded := 0
		var dir := DirAccess.open("res://resources/themes")
		if dir == null:
			printerr("[ThemeLib] Could not load themes")
		else:
			print("[ThemeLib] Loading custom themes...")
			dir.list_dir_begin()
			for file: String in dir.get_files():
				if (file.begins_with("themelib_")):
					var resource := load(dir.get_current_dir() + "/" + file)
					theme_manifest.items.append(resource)
					print("[ThemeLib] Loaded custom theme \"%s\"" % resource.id)
					custom_themes_loaded += 1
			print("[ThemeLib] Loaded %d custom themes" % custom_themes_loaded)
]]
	)

	return src
end

--------- wallpapers

local function patch_wallpapers(src)
	src = utils.replace(
		src,
		"wallpaper.starter = stem == DEFAULT_WALLPAPER_ID",
		"wallpaper.starter = stem == DEFAULT_WALLPAPER_ID || custom_wallpaper_stems.has(stem)"
	)

	src = utils.replace(
		src,
		"var themes: Dictionary = {}",
		[[var themes: Dictionary = {}
var custom_wallpaper_stems: Array[String] = [] ]]
	)

	src = utils.replace(
		src,
		"func load_catalogs() -> void :",
		[[
func _load_custom_wallpaper(path: String) -> Texture2D:
	var image: Image = Image.load_from_file(path)
	var stem: String = path.get_file().get_basename()
	print("[ThemeLib] Loaded custom wallpaper \"%s\"" % stem)
	custom_wallpaper_stems.append(stem)

	if image.is_empty():
		push_warning("Failed to load image: " + path)
		return null

	image.resize(768, 480, Image.INTERPOLATE_LANCZOS)

	var texture: Texture2D = ImageTexture.create_from_image(image)
	return texture


func load_catalogs() -> void :]]
	)

	src = utils.replace(
		src,
		'const WALLPAPERS_DIR: String = "res://assets/wallpapers"',
		[[const WALLPAPERS_DIR: String = "res://assets/wallpapers"
const CUSTOM_WALLPAPERS_DIR: String = "res://assets/custom_wallpapers"]]
	)

	src = utils.replace(
		src,
		"var wallpaper_files: PackedStringArray = ResourceLoader.list_directory(WALLPAPERS_DIR)",
		[[var wallpaper_files: PackedStringArray = ResourceLoader.list_directory(WALLPAPERS_DIR)
	wallpaper_files.append_array(DirAccess.get_files_at(CUSTOM_WALLPAPERS_DIR))]]
	)

	src = utils.replace(
		src,
		'var texture: Texture2D = load(WALLPAPERS_DIR.path_join(stem + ".png")) as Texture2D',
		[[var filename: String = stem + ".png"
		var path: String = WALLPAPERS_DIR.path_join(filename)
		var texture: Texture2D = (
			load(path)
			if ResourceLoader.exists(path)
			else _load_custom_wallpaper(CUSTOM_WALLPAPERS_DIR.path_join(filename))
		)]]
	)

	return src
end

--- um

GDPatch.patch_script_as_text("scenes/autoload/appearance_manager.gdc", function(_ctx, src)
	if GDPatch.get_config_option(nil, "enable", "themes") then
		src = patch_themes(src)
	end
	if GDPatch.get_config_option(nil, "enable", "wallpapers") then
		src = patch_wallpapers(src)
	end

	return src
end)
