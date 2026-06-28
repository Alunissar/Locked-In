extends Control
class_name GUIManager

@onready var floor_name: LabelPlus = $"Panel/Floor Name"
@onready var stars: LabelPlus = $Panel/Stars
@onready var energy: LabelPlus = $Panel/Energy
@onready var dex: LabelPlus = $Panel/Dex
@onready var clv: LabelPlus = $Panel/Clv
@onready var tec: LabelPlus = $Panel/Tec
@onready var dex_mult: LabelPlus = $Panel/DexMult
@onready var clv_mult: LabelPlus = $Panel/ClvMult
@onready var tec_mult: LabelPlus = $Panel/TecMult
@onready var key_count: LabelPlus = $Panel/KeyCount
@onready var hover_name: LabelPlus = $Panel/HoverName
@onready var hover_description: RichTextLabel = $Panel/HoverDescription


func _ready() -> void:
	GameManager.PCInstance.connect("gained_health", func(_x):energy.text_set(Global.insert_group_splitters(str(GameManager.PCInstance.HP))))
	GameManager.PCInstance.connect("gained_dex", func(_x):dex.text_set(Global.insert_group_splitters(str(GameManager.PCInstance.eff_dex()))))
	GameManager.PCInstance.connect("gained_clv", func(_x):clv.text_set(Global.insert_group_splitters(str(GameManager.PCInstance.eff_clv()))))
	GameManager.PCInstance.connect("gained_tec", func(_x):tec.text_set(Global.insert_group_splitters(str(GameManager.PCInstance.eff_tec()))))
	GameManager.PCInstance.connect("gained_key", func(_x):key_count.text_set(str(GameManager.PCInstance.KEY)))
	GameManager.PCInstance.connect("gained_star", func(_x):stars.text_set(str(GameManager.PCInstance.STAR)))
	GameManager.change_floor.connect(change_floor_name)
	#dex_mult.visible = false
	#clv_mult.visible = false
	#tec_mult.visible = false
	#hover_name.visible = false
	#hover_description.visible = false
	
	InputManager.connect("hover_changed", change_hover_text)
	
	update_all()
	pass

func update_all() -> void:
	energy.text_set(Global.insert_group_splitters(str(GameManager.PCInstance.HP)))
	dex.text_set(Global.insert_group_splitters(str(GameManager.PCInstance.eff_dex())))
	clv.text_set(Global.insert_group_splitters(str(GameManager.PCInstance.eff_clv())))
	tec.text_set(Global.insert_group_splitters(str(GameManager.PCInstance.eff_tec())))
	key_count.text_set(str(GameManager.PCInstance.KEY))
	stars.text_set(str(GameManager.PCInstance.STAR))
	dex_mult.text_set(str(int(100*float(GameManager.PCInstance.eff_dex()) / GameManager.PCInstance.DEX)) + "%")
	clv_mult.text_set(str(int(100*float(GameManager.PCInstance.eff_clv()) / GameManager.PCInstance.CLV)) + "%")
	tec_mult.text_set(str(int(100*float(GameManager.PCInstance.eff_tec()) / GameManager.PCInstance.TEC)) + "%")
	change_floor_name(1)
	pass

func change_hover_text(pos:Vector2i):
	hover_name.text_set("")
	hover_description.text = ""
	var tile = GameManager.currentLevel.get_tile_at(pos)
	dex_mult.text_set(str(GameManager.PCInstance.final_mult()) + "%")
	clv_mult.text_set(str(GameManager.PCInstance.final_mult()) + "%")
	tec_mult.text_set(str(GameManager.PCInstance.final_mult()) + "%")
	dex.text_set(Global.insert_group_splitters(str(GameManager.PCInstance.eff_dex())))
	clv.text_set(Global.insert_group_splitters(str(GameManager.PCInstance.eff_clv())))
	tec.text_set(Global.insert_group_splitters(str(GameManager.PCInstance.eff_tec())))
	match tile:
		"item":
			var item = GameManager.currentLevel.get_item_at(pos)
			hover_name.text_set(Item.item_name(item.id, item.lvl))
			hover_description.text = Item.item_description(item.id, item.lvl)
			var actions:Array[Action] = Item.interact(item["id"], item["lvl"])
			if(actions[0] is Combat):
				dex_mult.text_set(str(GameManager.PCInstance.final_mult(actions[0]._dex_mult)) + "%")
				clv_mult.text_set(str(GameManager.PCInstance.final_mult(actions[0]._clv_mult)) + "%")
				tec_mult.text_set(str(GameManager.PCInstance.final_mult(actions[0]._tec_mult)) + "%")
				dex.text_set(Global.insert_group_splitters(str(GameManager.PCInstance.eff_dex(actions[0]._dex_mult))))
				clv.text_set(Global.insert_group_splitters(str(GameManager.PCInstance.eff_clv(actions[0]._clv_mult))))
				tec.text_set(Global.insert_group_splitters(str(GameManager.PCInstance.eff_tec(actions[0]._tec_mult))))
		"gate":
			hover_name.text_set("Gate")
			hover_description.text = "Needs a key to open."
		"1sgate":
			hover_name.text_set("Star Gate")
			hover_description.text = "Needs a star to open."
		"5sgate":
			hover_name.text_set("Silver Star Gate")
			hover_description.text = "Needs 5 stars to open."
		"25sgate":
			hover_name.text_set("BIG Star Gate")
			hover_description.text = "Needs a whopping 25 stars to open. This better be worth it."
		"UPstairs":
			hover_name.text_set("Stairs")
			hover_description.text = "To go up a floor."
		"DOWNstairs":
			hover_name.text_set("Stairs")
			hover_description.text = "To go down a floor."
	pass

func change_floor_name(floor:int):
	floor_name.text_set("Floor " + str(floor))
