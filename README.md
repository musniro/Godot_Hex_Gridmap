# Godot_Hex_Gridmap

This repo contains the code to support Hexagonal gridmaps in godot.
It also contains a demo in the form of a godot project with scene 'HexMapd3d_test.tscn'

### HexMap interface
 

HexMap functions:
  - get_distance_between(a,b) : get distance between mappos a and b
  - set_obj_pos_HEX(object,mappos) : move object to the given mappos
  - world_to_map_HEX(pos: Vector3)
  - map_to_world_HEX(mappos: Vector2) 
  - has_tile_HEX(mappos: Vector2)
  - get_cell_HEX(x : int, y : int)
  - set_cell_HEX(x: int, y: int, tile_int: int)

These last five are the interfaces to the GridMap functions.
The HexMap script corrects the coordinate system for you to the following usable format:

![image](https://user-images.githubusercontent.com/28194128/144512637-b44e9066-e74a-4e50-b9f8-9e8d331fc248.png)

HexMap signals
  - on_hover
  - on_left_click
  
Camera functions:
  - get_mousepos3d(mouse_pos : Vector2)
  
  
### How to use hextiles in the 3D Gridmap in Godot
 
We are going to create the following structure

![image](https://user-images.githubusercontent.com/28194128/144706684-c0bc08aa-2792-46c4-849e-1b7f0349fc71.png)

First create the camera and add the Camera.gd script. This script supports getting the 3d position from the mouse position

Create a Gridmap with property Cell>Size (1,0.2,1.732) as shown below. This works at least for kaykit's hextiles.
Give it a pointer to the camera node and mesh library to use and add the HexMap script to the node.

![image](https://user-images.githubusercontent.com/28194128/144706646-8e175454-963d-4fd7-bd6e-73ad86171adf.png)

Instance the UI_info scene as a child of the gridmap, this is a way to show information about the tiles. For now it shows the coorinates.

Now connect the on_hover and on_left_click signals from HexMaps. For now connect on_hover to UI_info, and on_left_click to HexMap itself.

![image](https://user-images.githubusercontent.com/28194128/144706763-327c798f-87a2-4e71-bd24-cef5e6ddd617.png)  
  
### Known limitations
For now the HexMap can only correctly support tiles on level 0.
The camera get_mousepos3d returns projection of the mouse position onto a flat plane at height 0. This correlates okay with a tilemap as long as it is also at height 0.

  
