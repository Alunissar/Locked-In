extends Node

signal hover_changed(Vector2i)
var hovered_coord:Vector2i

signal toggle_numbers(bool)

func _input(event) -> void:
	if event.is_action_pressed("in_down"):
		GameManager.PCInstance.move("S")
	if event.is_action_pressed("in_up"):
		GameManager.PCInstance.move("N")
	if event.is_action_pressed("in_left"):
		GameManager.PCInstance.move("W")
	if event.is_action_pressed("in_right"):
		GameManager.PCInstance.move("E")
	if event.is_action_pressed("in_undo"):
		CommandStack.undo()
	if event.is_action_pressed("in_redo"):
		CommandStack.redo()
	if event.is_action_pressed("in_tab"):
		toggle_numbers.emit(true)
	if event.is_action_released("in_tab"):
		toggle_numbers.emit(false)
	
	if event is InputEventMouseMotion:
		var grid_pos = GameManager.global_to_grid(event.global_position)
		if hovered_coord != grid_pos:
			hovered_coord = grid_pos
			hover_changed.emit(hovered_coord)
	
	if event is InputEventMouseButton and event.is_released():
		var pos2 = GameManager.global_to_grid(event.global_position)
		if(GameManager.currentLevel.can_pathfind(GameManager.PCInstance.grid_pos, pos2)):
			GameManager.PCInstance.move_to(pos2)
			pass 
	
