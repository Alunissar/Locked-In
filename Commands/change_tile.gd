extends Action
class_name ChangeTile

var _position:Vector2i
var _tile_from:int
var _tile_to:int

func _init(pos:Vector2i,tile_to:int):
	_position = pos
	_tile_from = GameManager.currentLevel.get_tile_id(pos)
	_tile_to = tile_to
	pass

func forward():
	GameManager.currentLevel.set_tile_at(_position, _tile_to)
	pass

func reverse():
	GameManager.currentLevel.set_tile_at(_position, _tile_from)
	pass
