extends Node

const CROSS_OUT_SPRITE = preload("uid://v582t2hjwud6")
const PATH_SPRITE = preload("uid://b7qedayop2kex")

func insert_group_splitters(value:String, splitter:String = ".", group_size:int = 3):
	
	var temp = value
	
	value = temp.left(temp.length()%group_size)
	temp = temp.trim_prefix(value)
	
	for i in temp.length()/group_size:
		value += splitter
		
		value += temp.left(group_size)
		temp = temp.trim_prefix(temp.left(group_size))
	
	value = value.trim_prefix(splitter)
	return value

func spawn_path(pos1:Vector2i,pos2:Vector2i):
	var sprite = Sprite2D.new()
	sprite.texture = PATH_SPRITE
	sprite.position = (GameManager.grid_to_global(pos1) + GameManager.grid_to_global(pos2))/2
	if(pos1.x != pos2.x): sprite.rotation_degrees = 90
	get_tree().root.add_child(sprite)
	var timer = Timer.new()
	sprite.add_child(timer)
	timer.start(0.1)
	timer.timeout.connect(func _x(): sprite.queue_free())
	pass

func spawn_cross(pos:Vector2i):
	var cross = Sprite2D.new()
	cross.texture = CROSS_OUT_SPRITE
	cross.position = GameManager.grid_to_global(pos)
	get_tree().root.add_child(cross)
	var timer2 = Timer.new()
	cross.add_child(timer2)
	timer2.start(0.2)
	timer2.timeout.connect(func _x(): cross.queue_free())
	pass
