extends Action
class_name AddStat

var _hp:int
var _dex:int
var _clv:int
var _tec:int
var _key:int
var _star:int

func _init(hp:int, dex:int, clv:int, tec:int, key:int = 0, star:int = 0) -> void:
	_hp = hp
	_dex = dex
	_clv = clv
	_tec = tec
	_key = key
	_star = star
	pass


func forward():
	GameManager.PCInstance.gain_health(_hp)
	GameManager.PCInstance.gain_dex(_dex)
	GameManager.PCInstance.gain_clv(_clv)
	GameManager.PCInstance.gain_tec(_tec)
	GameManager.PCInstance.gain_key(_key)
	GameManager.PCInstance.gain_star(_star)
	pass

func reverse():
	GameManager.PCInstance.gain_health(-_hp)
	GameManager.PCInstance.gain_dex(-_dex)
	GameManager.PCInstance.gain_clv(-_clv)
	GameManager.PCInstance.gain_tec(-_tec)
	GameManager.PCInstance.gain_key(-_key)
	GameManager.PCInstance.gain_star(-_star)
	pass
