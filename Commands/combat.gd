extends Action
class_name Combat

var _lvl:int
var _hp:int
var _dex_mult:float
var _clv_mult:float
var _tec_mult:float
var _turns_taken:int = 0

func damage_step_value() -> int:
	return (GameManager.PCInstance.eff_dex(_dex_mult))+(GameManager.PCInstance.eff_clv(_clv_mult))+(GameManager.PCInstance.eff_tec(_tec_mult))

func calc_combat_results() -> Variant:
	var turn_count:int = ceil(_hp / (damage_step_value()))-1
	var damage_taken:int = _lvl * turn_count
	var TRT:int = ceil(float(_hp)/(turn_count-1)-damage_step_value())
	print (damage_taken, " damage taken in ", turn_count-1, " turns. TRT: ", TRT)
	return {turns = turn_count, damage = damage_taken, TRT = TRT}

func _init(lvl:int, hp:int, dexmult:float, clvmult:float, tecmult:float) -> void:
	_lvl = lvl
	_hp = hp
	_dex_mult = dexmult
	_clv_mult = clvmult
	_tec_mult = tecmult
	

func forward():
	var calc = calc_combat_results()
	print(calc)
	
	_turns_taken = calc.turns
	for turn in calc.turns:
		_hp -= damage_step_value()
		if _hp<=0:
			return
		
		GameManager.PCInstance.gain_health(-_lvl)
		if GameManager.PCInstance.HP <= 0:
			return
	return

func reverse():
	
	for turn in _turns_taken:
		_hp += damage_step_value()
		GameManager.PCInstance.gain_health(_lvl)
	
	return
