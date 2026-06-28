extends Node

var redo_stack:Node

func _init() -> void:
	redo_stack = Node.new()
	redo_stack.name = "RedoStack"
	add_child(redo_stack)

func make_command(actions:Array[Action], pos1:Vector2i, pos2:Vector2i):
	if(redo_stack.get_child_count()>0):
		for child in redo_stack.get_children():
			child.queue_free()
	
	var command = Command.new(pos1, pos2, GameManager.currentLevel.current_floor, actions)
	add_child(command)
	command.execute()

func undo():
	if(get_child_count() <2): return
	
	var command = get_child(-1) as Command
	
	command.undo()
	remove_child(command)
	redo_stack.add_child(command)

func redo():
	if(redo_stack.get_child_count() <1): return
	
	var command = redo_stack.get_child(-1) as Command
	
	command.execute()
	redo_stack.remove_child(command)
	add_child(command)
