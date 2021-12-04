extends Camera

const RAY_LENGTH = 1000

func _get_rays(mouse_pos : Vector2):
		var ray_from = project_ray_origin(mouse_pos)
		var ray_to = ray_from + project_ray_normal(mouse_pos) * RAY_LENGTH
		return {'from':ray_from,'to':ray_to}
		
func get_mousepos3d(mouse_pos : Vector2):
		var rays = _get_rays(mouse_pos)
		
		var plane = Plane(Vector3.UP, 0)
		var intersection = plane.intersects_ray (rays['from'], rays['to'] )
		return intersection
		
func get_object_under_mouse(mouse_pos : Vector2):
		#Only returns object with collision enabled
		var rays = _get_rays(mouse_pos)
		
		var space_state = get_world().direct_space_state
		var selection = space_state.intersect_ray(rays['from'], rays['to'])
		return selection
