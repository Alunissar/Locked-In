extends Node
class_name Command

var _pos_from:Vector2i
var _pos_to:Vector2i
var _floor:int
var _actions:Array[Action]
var prev_task_count:int
var _prev_floor:int

func _init(pos_from:Vector2i, pos_to:Vector2i,floor:int, actions:Array[Action]) -> void:
	_pos_from = pos_from
	_pos_to = pos_to
	_floor = floor
	_prev_floor = GameManager.PCInstance.current_floor
	_actions = actions
	for action in actions:
		add_child(action)

func execute():
	GameManager.currentLevel.set_floor(_floor)
	prev_task_count = GameManager.PCInstance.task_counter
	GameManager.PCInstance.grid_pos = _pos_to
	GameManager.PCInstance.position = GameManager.grid_to_global(_pos_to)
	for action in _actions:
		action.forward()
		if(action is Combat):
			if(_prev_floor == _floor):
				GameManager.PCInstance.count_task()
			else:
				GameManager.PCInstance.reset_count_task()
				GameManager.PCInstance.current_floor = _floor
	
	InputManager.hover_changed.emit(InputManager.hovered_coord)
	pass

func undo():
	GameManager.currentLevel.set_floor(_floor)
	GameManager.PCInstance.set_count_task(prev_task_count)
	GameManager.PCInstance.current_floor = _prev_floor
	GameManager.PCInstance.grid_pos = _pos_from
	GameManager.PCInstance.position = GameManager.grid_to_global(_pos_from)
	for i in range(_actions.size()-1,-1,-1):
		_actions[i].reverse()
	
	
	InputManager.hover_changed.emit(InputManager.hovered_coord)
	pass
