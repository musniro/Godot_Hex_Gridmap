extends GridMap

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
	
func _is_odd(x):
	return int(x) % 2 == 1
	
func get_distance_between(a,b):
	var d = b-a
	var dist = max(max(abs(d.x), abs(d.y)), abs(d.x+d.y))
	#print(a,b,d,dist)
	return dist

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
