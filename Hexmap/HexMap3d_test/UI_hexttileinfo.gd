extends Node2D

export(bool) var ALWAYS_SHOW_COORDINATES = true

func set_text(s):
	$text.text = s
	
func _on_HexMap_on_hover(hexmap,mappos,mouse_pos):
	hide()
	if ALWAYS_SHOW_COORDINATES or hexmap.has_tile_HEX(mappos):
		show()
		set_text(String (mappos))
		global_position = mouse_pos
