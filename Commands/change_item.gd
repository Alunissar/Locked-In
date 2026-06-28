extends Action
class_name ChangeItem

var _position:Vector2i
var _item_from:int
var _item_to:int

func _init(pos:Vector2i,item_to:int):
	_position = pos
	_item_from = GameManager.currentLevel.get_item_at(pos)["id"]
	_item_to = item_to
	pass

func forward():
	GameManager.currentLevel.set_item_at(_position, _item_to)
	pass

func reverse():
	GameManager.currentLevel.set_item_at(_position, _item_from)
	pass
