extends Node2D
class_name PlayerCharacter

# Component references
const PLAYER_NORMAL = preload("uid://4msn7ftvsc3e")
const PLAYER_LOCKIN = preload("uid://dawp3ys6ahvam")

var normal_sprt: Sprite2D
var lockin_sprt: Sprite2D

var is_lockin:bool
var task_counter:int
var current_floor:int

var HP:int
var DEX:int
func eff_dex(mult:float = 1) -> int:
	return DEX * final_mult(mult)/100
var CLV:int
func eff_clv(mult:float = 1) -> int:
	return CLV * final_mult(mult)/100
var TEC:int
func eff_tec(mult:float = 1) -> int:
	return TEC * final_mult(mult)/100
var KEY:int
var STAR:int

func final_mult(mult:float = 1) ->int:
	if(is_lockin): return 100 * mult * 1.5
	else: return 100 * mult * (0.9+0.05*task_counter)

# State variables
var grid_pos: Vector2i

func _enter_tree() -> void:
	GameManager.PCInstance = self
	
	normal_sprt = Sprite2D.new()
	normal_sprt.texture = PLAYER_NORMAL
	lockin_sprt = Sprite2D.new()
	lockin_sprt.texture = PLAYER_LOCKIN
	
	add_child(normal_sprt)
	add_child(lockin_sprt)
	
	is_lockin = false
	task_counter = 0
	lockin_sprt.visible = false
	
	# initial stats
	HP = 500
	DEX = 5
	CLV = 5
	TEC = 5
	KEY = 0
	pass

func _ready() -> void:
	grid_pos = GameManager.global_to_grid(global_position)
	global_position = GameManager.grid_to_global(grid_pos)

func set_lockin(value:bool):
	is_lockin = value
	if is_lockin:
		normal_sprt.visible = false
		lockin_sprt.visible = true
	else:
		normal_sprt.visible = true
		lockin_sprt.visible = false
	GameManager.cross_stairs(value)

func move(dir):
	match dir:
		"E":
			move_to(grid_pos + Vector2i(1,0))
			pass
		"N":
			move_to(grid_pos + Vector2i(0,-1))
			pass
		"W":
			move_to(grid_pos + Vector2i(-1,0))
			pass
		"S":
			move_to(grid_pos + Vector2i(0,1))
			pass
	pass

func move_to(pos: Vector2i) -> void:
	var tile = GameManager.currentLevel.get_tile_at(pos)
	
	print("Move input to " + tile + " at " + str(pos))
	
	match tile:
		"ground":
			grid_pos = pos
			global_position = GameManager.grid_to_global(grid_pos)
			pass
		"wall":
			pass
		"gate":
			if KEY > 0:
				var actions:Array[Action] = []
				actions.append(ChangeTile.new(pos,12))
				actions.append(AddStat.new(0,0,0,0,-1))
				CommandStack.make_command(actions, grid_pos, pos)
			pass
		"item":
			var item = GameManager.currentLevel.get_item_at(pos)
			if Item.can_grab(item["id"],item["lvl"]):
				var actions:Array[Action] = Item.interact(item["id"], item["lvl"])
				actions.append(ChangeItem.new(pos,-1))
				CommandStack.make_command(actions, grid_pos, pos)
				pass
			pass
		"1sgate":
			if STAR >= 1:
				var actions:Array[Action] = []
				actions.append(ChangeTile.new(pos,14))
				actions.append(AddStat.new(0,0,0,0,0,-1))
				CommandStack.make_command(actions, grid_pos, pos)
			pass
		"5sgate":
			if STAR >= 5:
				var actions:Array[Action] = []
				actions.append(ChangeTile.new(pos,14))
				actions.append(AddStat.new(0,0,0,0,0,-5))
				CommandStack.make_command(actions, grid_pos, pos)
			pass
		"25sgate":
			if STAR >= 25:
				var actions:Array[Action] = []
				actions.append(ChangeTile.new(pos,14))
				actions.append(AddStat.new(0,0,0,0,0,-25))
				CommandStack.make_command(actions, grid_pos, pos)
			pass
		"UPstairs":
			grid_pos = pos
			global_position = GameManager.grid_to_global(grid_pos)
			if(is_lockin): return
			GameManager.stairs_up()
		"DOWNstairs":
			grid_pos = pos
			global_position = GameManager.grid_to_global(grid_pos)
			if(is_lockin): return
			GameManager.stairs_down()
	
	pass

signal gained_health(amount:int)
func gain_health(amount:int) -> void:
	HP += amount
	gained_health.emit(amount)
	if(HP<=0): die()

signal gained_dex(amount:int)
func gain_dex(amount:int) -> void:
	DEX += amount
	gained_dex.emit(amount)

signal gained_clv(amount:int)
func gain_clv(amount:int) -> void:
	CLV += amount
	gained_clv.emit(amount)

signal gained_tec(amount:int)
func gain_tec(amount:int) -> void:
	TEC += amount
	gained_tec.emit(amount)

signal gained_key(amount:int)
func gain_key(amount:int) -> void:
	KEY += amount
	gained_key.emit(amount)

signal gained_star(amount:int)
func gain_star(amount:int) -> void:
	STAR += amount
	gained_star.emit(amount)

func count_task():
	task_counter += 1
	set_lockin(task_counter >= 5)

func set_count_task(value:int):
	task_counter = value
	set_lockin(task_counter >= 5)

func reset_count_task():
	task_counter = 0
	set_lockin(false)

func die() -> void:
	print("HA. ded.")
	pass
