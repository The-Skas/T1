tool 
extends Node
export(Texture) var texture
export var tileSize = Vector2(32,32)
export var tiles_to_map = Vector2()
export var generate = false
func _process (delta):
	if generate:
		generate = false

		if texture != null and get_child_count() < 1:

			var xwidth
			var ywidth
			var own = get_tree().get_edited_scene_root()
			if tiles_to_map == Vector2():
				xwidth = texture.get_siize().x / tileSize.x
				ywidth = texture.get_siize().y / tileSize.y
			else:
				xwidth = tiles_to_map.x
				ywidth = tiles_to_map.y
			
			for x in range(0, xwidth):
				for y in range(0, ywidth):
					print("adding child")
					var pos = Vector2(x,y) * tileSize
					var nd = Sprite.new()
					nd.position = pos + Vector2(x,y)
					nd.texture = texture
					nd.region_enabled = true
					nd.region_rect = Rect2(pos, tileSize)
					self.add_child(nd)
					