extends Action
class_name ChangeItem

var _position:Vector2i
var _item_from:int
var _item_to:int
var _lvl:int

func _init(pos:Vector2i,item_to:int):
	_position = pos
	_item_from = GameManager.currentLevel.get_item_at(pos)["id"]
	_item_to = item_to
	_lvl = GameManager.currentLevel.get_item_at(pos)["lvl"]
	pass

func forward():
	GameManager.currentLevel.set_item_at(_position, _item_to)
	GameManager.currentLevel.get_current_floor().powers.erase_cell(_position)
	pass

func reverse():
	GameManager.currentLevel.set_item_at(_position, _item_from)
	var atlas : Vector2i = Vector2i(_lvl%4-1, _lvl/4)
	GameManager.currentLevel.get_current_floor().powers.set_cell(_position, 0, atlas)
	pass
