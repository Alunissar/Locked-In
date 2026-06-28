extends Node2D
class_name Level

@export var floors:Array[Floor]
var current_floor:int
var astar_grid:AStarGrid2D

func _enter_tree() -> void:
	GameManager.currentLevel = self
	
	current_floor = 0
	
	for floor in floors:
		floor.visible = false
	
	# pathfinding settings
	astar_grid = AStarGrid2D.new()
	astar_grid.region = Rect2i(0,0,11,11)
	astar_grid.cell_size = Vector2i(32,32)
	astar_grid.offset = Vector2i(16,16)
	astar_grid.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar_grid.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()
	
	set_floor(current_floor)
	pass

func get_tile_at(pos:Vector2i) -> Variant:
	return floors[current_floor].get_tile_at(pos)

func get_tile_id(pos:Vector2i) -> int: #_items.get_cell_atlas_coords(pos).x + _items.get_cell_atlas_coords(pos).y*4
	var c = floors[current_floor].ground.get_cell_atlas_coords(pos)
	return c.x + c.y*4

func get_item_at(pos:Vector2i) -> Variant:
	return floors[current_floor].get_item_at(pos)

func set_item_at(pos:Vector2i, id:int):
	floors[current_floor]._items.set_cell(pos,0,Vector2i(id%4, id/4))
	astar_grid.set_point_solid(pos)
	if(id == -1): 
		astar_grid.set_point_solid(pos, false)
		floors[current_floor]._items.erase_cell(pos)
		print("used cells items: "+str(floors[current_floor]._items.get_used_cells().size()))
		if(floors[current_floor]._items.get_used_cells().size() == 0):
			GameManager.PCInstance.reset_count_task()
		pass
	update_astar()

func set_tile_at(pos:Vector2i, id:int):
	print("set tile to: "+ str(id))
	floors[current_floor].ground.set_cell(pos,0,Vector2i(id%4, id/4))
	update_astar()

func set_floor(value:int):
	floors[current_floor].visible = false
	current_floor = value
	floors[current_floor].visible = true
	
	update_astar()

func update_astar():
	astar_grid.update()
	for tile in floors[current_floor].ground.get_used_cells():
		var data =  floors[current_floor].ground.get_cell_tile_data(tile)
		if data and data.get_custom_data("obstacle"):
			astar_grid.set_point_solid(tile)
		else:
			astar_grid.set_point_solid(tile, false)
		
		data =  floors[current_floor]._items.get_cell_tile_data(tile)
		if data and data.get_custom_data("obstacle"):
			astar_grid.set_point_solid(tile)

func can_pathfind(pos1:Vector2i, pos2:Vector2i) -> bool:
	return astar_grid.get_id_path(pos1,pos2,false).size() > 0
