local utils = require("gdpatch.utils")

GDPatch.patch_script_as_text("scenes/game_object/clickables/vapor_icon/vapor_exe.gdc", function(ctx, src)
	src = src:gsub(
		utils.escape([[var puff: AnimatedSprite2D
		var icons: Array[Node] = icons_layer.get_children()
		for icon: Clickable in icons.filter( func(i: Node) -> bool:
			return i is Clickable and not i is SafeFolderIcon and not i is BossFile):
			if game_rect.has_point(icon.position):
				if icon != self:
					puff = VAPOR_PUFF.instantiate()
					icons_layer.add_child(puff)
					puff.position = icon.position
					destroyed_count += 1
					icon.vaporize()]]),
		utils.escape("", true),
		1
	)

	return src
end)
