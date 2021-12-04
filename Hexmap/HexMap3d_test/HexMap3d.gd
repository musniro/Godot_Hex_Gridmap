extends GridMap
class_name HexMap

signal on_left_click(hexmap,mappos,mouse_pos)
signal on_hover(hexmap,mappos,mouse_pos)

export(NodePath) var Camera_np = null
onready var Cam = get_node(Camera_np)

export(bool) var ALWAYS_SHOW_COORDINATES = true

func get_distance_between(a,b):
	var d = b-a
	var dist = max(max(abs(d.x), abs(d.y)), abs(d.x+d.y))
	#print(a,b,d,dist)
	return dist

#_HEX suffix because I cannot overwrite a function while requiring different arguments
func set_obj_pos_HEX(object,obj_mappos):
	"""
	Moves object to obj_mappos
	"""
	object.set_position_HEX(map_to_world_HEX(obj_mappos))
	.set_obj_pos(object,obj_mappos)
			
func world_to_map_HEX(pos: Vector3):
	var mappos = .world_to_map(pos)
	return _correct_mappos(Vector2(mappos.x,mappos.z))
	
func map_to_world_HEX(mappos: Vector2) -> Vector3:
	mappos = _uncorrect_mappos(mappos) 
	return .map_to_world(mappos.x,0,mappos.y)

func has_tile_HEX(mappos):
	return get_cell_HEX(mappos.x,mappos.y) > -1
		
func get_cell_HEX(x,y):
	var mappos := _uncorrect_mappos(Vector2(x,y))
	return .get_cell_item(mappos.x,0,mappos.y)

func set_cell_HEX(x: int, y: int, tile_int: int):
	var mappos := _uncorrect_mappos(Vector2(x,y))
	.set_cell_item(mappos.x,0,mappos.y,tile_int)
	
func _correct_mappos(mappos : Vector2) -> Vector2:
	#correct for double grid
	mappos.x /= 2 
	mappos.x = ceil(mappos.x)
	
	#correct for hex grid
	mappos = Vector2(mappos.x-floor(mappos.y/2),mappos.y) 
	return mappos

func _uncorrect_mappos(mappos : Vector2) -> Vector2:
	#uncorrect for hex grid
	mappos = Vector2(mappos.x+floor(mappos.y/2),mappos.y) 
	
	#uncorrect for double grid
	mappos.x *= 2 
	if not _is_odd(mappos.y):
		mappos.x -= 1
	return mappos

func _is_odd(x):
	return int(x) % 2 == 1

var cprevpos  # prev click pos
var cprevtile # prev click tile
func _on_HexMap_on_left_click(_hexmap, mappos, _mouse_pos):
	if cprevtile != null:
		set_cell_HEX(cprevpos.x,cprevpos.y,cprevtile)
	cprevtile = get_cell_HEX(mappos.x,mappos.y)
	cprevpos = mappos
	set_cell_HEX(mappos.x,mappos.y,20)

#
# mouse inputs
#
func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		var mappos = _mouse_pos_to_map(event.position)
		if mappos != null:
			emit_signal("on_left_click",self,mappos,event.position)
	if event is InputEventMouse:
		var mappos = _mouse_pos_to_map(event.position)
		if mappos != null:
			emit_signal("on_hover",self,mappos,event.position)
	
func _mouse_pos_to_map(mouse_pos : Vector2):
	var world_pos = Cam.get_mousepos3d(mouse_pos)
	if world_pos == null:
		return null
	return world_to_map_HEX(world_pos)


