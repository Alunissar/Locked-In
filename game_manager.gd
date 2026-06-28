extends Node

var currentLevel:Level
var PCInstance:PlayerCharacter
var crosses:Array[Node]

func global_to_grid(pos:Vector2) -> Vector2i:
	return currentLevel.floors[0].ground.local_to_map(pos)

func grid_to_global(pos:Vector2i) -> Vector2:
	return currentLevel.floors[0].ground.map_to_local(pos)

signal change_floor(floor:int)

func stairs_up():
	currentLevel.set_floor(currentLevel.current_floor+1)
	change_floor.emit(currentLevel.current_floor+1)

func stairs_down():
	currentLevel.set_floor(currentLevel.current_floor-1)
	change_floor.emit(currentLevel.current_floor+1)

func cross_stairs(value:bool):
	if(value):
		for tile in currentLevel.floors[currentLevel.current_floor].ground.get_used_cells():
			if currentLevel.get_tile_at(tile) == "UPstairs" or currentLevel.get_tile_at(tile) == "DOWNstairs":
				var cross = Sprite2D.new()
				cross.texture = preload("uid://v582t2hjwud6")
				cross.position = grid_to_global(tile)
				currentLevel.add_child(cross)
				crosses.append(cross)
	else:
		for cross in crosses:
			cross.queue_free()
		crosses.clear()
