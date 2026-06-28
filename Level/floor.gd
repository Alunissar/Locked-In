extends Node2D
class_name Floor

@export var ground:TileMapLayer
@export var _items:TileMapLayer
@export var powers:TileMapLayer

func _ready() -> void:
	powers.visible = false
	InputManager.toggle_numbers.connect(func(_x): powers.visible = _x)

func get_tile_at(pos:Vector2i) -> Variant:
	if(_items.get_cell_atlas_coords(pos) != Vector2i(-1,-1)):
		print(_items.get_cell_atlas_coords(pos))
		return "item"
	var coords = ground.get_cell_atlas_coords(pos)
	
	if(coords.x == 0): return "ground"
	if(coords.x == 1): return "wall"
	match coords:
		Vector2i(2,3): return "ground"
		Vector2i(3,3): return "wall"
		Vector2i(2,0): return "gate"
		Vector2i(3,0): return "1sgate"
		Vector2i(2,1): return "5sgate"
		Vector2i(3,1): return "25sgate"
		Vector2i(2,2): return "UPstairs"
		Vector2i(3,2): return "DOWNstairs"
	
	return null

func get_item_at(pos:Vector2i) -> Variant:
	var ID:int = _items.get_cell_atlas_coords(pos).x + _items.get_cell_atlas_coords(pos).y*4
	var LVL:int = 1+powers.get_cell_atlas_coords(pos).x + powers.get_cell_atlas_coords(pos).y*4
	
	return {"id": ID, "lvl":LVL}
