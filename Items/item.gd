extends Node
class_name Item

const hp_values = [1000, 3000, 5000, 7000, 10000, 13000, 16000, 20000, 25000, 30000, 40000, 50000, 60000, 70000, 80000]

static func interact(id:int, lvl:int) -> Array[Action]:
	match id:
		0:
			# tec job
			var out:Array[Action] = []
			out.append(Combat.new(lvl, hp_values[lvl], 0.5, 0.5, 2.0))
			var star
			if(lvl<=4): star = 1
			elif lvl <= 9: star = 5
			else: star = 25
			out.append(AddStat.new(0,0,0,1,0,star))
			return out
		1:
			# clv job
			var out:Array[Action] = []
			out.append(Combat.new(lvl, hp_values[lvl], 0.5, 2.0, 0.5))
			var star
			if(lvl<=4): star = 1
			elif lvl <= 9: star = 5
			else: star = 25
			out.append(AddStat.new(0,0,0,0,0,star))
			return out
		2:
			# dex job
			var out:Array[Action] = []
			out.append(Combat.new(lvl, hp_values[lvl], 2.0, 0.5, 0.5))
			var star
			if(lvl<=4): star = 1
			elif lvl <= 9: star = 5
			else: star = 25
			out.append(AddStat.new(0,0,0,0,0,star))
			return out
		3:
			# cooking
			var out:Array[Action] = []
			out.append(Combat.new(lvl, hp_values[lvl], 2.0, 0.5, 0.5))
			out.append(AddStat.new(50*lvl,0,0,0))
			return out
		4:
			# board game
			var out:Array[Action] = []
			out.append(Combat.new(lvl, hp_values[lvl], 1, 1, 1))
			out.append(AddStat.new(0,0,lvl,0))
			return out
		5:
			# computer game
			var out:Array[Action] = []
			out.append(Combat.new(lvl, hp_values[lvl], 0, 2, 2))
			out.append(AddStat.new(25*lvl,0,0,0))
			return out
		6:
			# pizza
			var out:Array[Action] = []
			out.append(AddStat.new(100,0,0,0))
			return out
		7:
			# cookies
			var out:Array[Action] = []
			out.append(AddStat.new(20,0,0,0))
			return out
		8:
			# pie
			var out:Array[Action] = []
			out.append(AddStat.new(500,0,0,0))
			return out
		9:
			# 1 star
			var out:Array[Action] = []
			out.append(AddStat.new(0,0,0,0,0,1))
			return out
		10: 
			# 5 star
			var out:Array[Action] = []
			out.append(AddStat.new(0,0,0,0,0,5))
			return out
		11: 
			# 25 star
			var out:Array[Action] = []
			out.append(AddStat.new(0,0,0,0,0,25))
			return out
		12:
			# key
			var out:Array[Action] = [AddStat.new(0,0,0,0,1)]
			return out
		13:
			# weight
			var out:Array[Action] = [AddStat.new(0,lvl,0,0)]
			return out
		14:
			# disk
			var out:Array[Action] = [AddStat.new(0,0,0,lvl)]
			return out
		15:
			# book
			var out:Array[Action] = [AddStat.new(0,0,lvl,0)]
			return out
		
	return[]

static func can_grab(id:int, lvl:int) ->bool:
	match id:
		0:
			# tec job
			var combat = Combat.new(lvl, hp_values[lvl], 0.5, 0.5, 2.0)
			var calc = combat.calc_combat_results()
			return calc.damage < GameManager.PCInstance.HP
		1:
			# clv job
			var combat = Combat.new(lvl, hp_values[lvl],0.5, 2.0, 0.5)
			var calc = combat.calc_combat_results()
			return calc.damage < GameManager.PCInstance.HP
		2:
			# dex job
			var combat = Combat.new(lvl, hp_values[lvl], 2.0, 0.5, 0.5)
			var calc = combat.calc_combat_results()
			return calc.damage < GameManager.PCInstance.HP
		3:
			# cooking
			var combat = Combat.new(lvl, hp_values[lvl], 2.0, 0.5, 0.5)
			var calc = combat.calc_combat_results()
			return calc.damage < GameManager.PCInstance.HP
		4:
			# board game
			var combat = Combat.new(lvl, hp_values[lvl], 1.0, 1.0, 1.0)
			var calc = combat.calc_combat_results()
			return calc.damage < GameManager.PCInstance.HP
		5:
			# computer game
			var combat = Combat.new(lvl, hp_values[lvl], 0.0, 2.0, 2.0)
			var calc = combat.calc_combat_results()
			return calc.damage < GameManager.PCInstance.HP
		6:
			# pizza
			return true
		7:
			# cookies
			return true
		8:
			# pie
			return true
		9:
			# 1 star
			return true
		10: 
			# 5 star
			return true
		11: 
			# 25 star
			return true
		12:
			# key
			return true
		13:
			# weight
			return true
		14:
			# disk
			return true
		15:
			# book
			return true
	
	return false

static func item_name(id:int, lvl:int) -> String:
	match id:
		0: return "Computer Task (" + str(lvl) + ")"
		1: return "Writing Task (" + str(lvl) + ")"
		2: return "Crafting Task (" + str(lvl) + ")"
		3: return "Cooking (" + str(lvl) + ")"
		4: return "Board Game (" + str(lvl) + ")"
		5: return "Puzzle Game (" + str(lvl) + ")"
		6: return "Pizza"
		7: return "Cookies"
		8: return "Delicious Pie"
		9: return "Star"
		10: return "Silver Star (5)"
		11: return "BIG Star (25)"
		12: return "Key"
		13: return "Dexterity UP (" + str(lvl) + ")"
		14: return "Tech UP (" + str(lvl) + ")"
		15: return "Clever UP (" + str(lvl) + ")"
	
	return ""

static func item_description(id:int, lvl:int) -> String:
	match id:
		0:
			# tec job
			var combat = Combat.new(lvl, hp_values[lvl], 0.5, 0.5, 2.0)
			var calc = combat.calc_combat_results()
			var star
			if(lvl<=4): star = "a star."
			elif lvl <= 9: star = "a silver(5) star."
			else: star = "a BIG(25) star."
			return "Tech-based. Gives 1 tech skill and "+ str(star) +" Will spend " + str(calc.damage) + " energy in " + str(calc.turns) + " turns. " + str(calc.TRT) + " effective skill to reduce turns."
		1:
			# clv job
			var combat = Combat.new(lvl, hp_values[lvl],0.5, 2.0, 0.5)
			var calc = combat.calc_combat_results()
			var star
			if(lvl<=4): star = "Gives a star."
			elif lvl <= 9: star = "Gives a silver(5) star."
			else: star = "Gives a BIG(25) star."
			return "Clever-based. "+ str(star) +" Will spend " + str(calc.damage) + " energy in " + str(calc.turns) + " turns. " + str(calc.TRT) + " effective skill to reduce turns."
		2:
			# dex job
			var combat = Combat.new(lvl, hp_values[lvl], 2.0, 0.5, 0.5)
			var calc = combat.calc_combat_results()
			var star
			if(lvl<=4): star = "Gives a star."
			elif lvl <= 9: star = "Gives a silver(5) star."
			else: star = "Gives a BIG(25) star."
			return "Dexterity-based. "+ str(star) +" Will spend " + str(calc.damage) + " energy in " + str(calc.turns) + " turns. " + str(calc.TRT) + " effective skill to reduce turns."
		3:
			# cooking 
			var combat = Combat.new(lvl, hp_values[lvl], 2.0, 0.5, 0.5)
			var calc = combat.calc_combat_results()
			return "Dexterity-based. Restores "+ str(50*lvl) +" energy. Will spend " + str(calc.damage) + " energy in " + str(calc.turns) + " turns. " + str(calc.TRT) + " effective skill to reduce turns."
		4:
			# board game
			var combat = Combat.new(lvl, hp_values[lvl], 1.0, 1.0, 1.0)
			var calc = combat.calc_combat_results()
			return "Gives "+ str(lvl) +" clever skill. Will spend " + str(calc.damage) + " energy in " + str(calc.turns) + " turns. " + str(calc.TRT) + " effective skill to reduce turns."
		5:
			# computer game 25*lvl
			var combat = Combat.new(lvl, hp_values[lvl], 0.0, 2.0, 2.0)
			var calc = combat.calc_combat_results()
			return "Clever+Teck. Restores "+ str(25*lvl) +" energy. Will spend " + str(calc.damage) + " energy in " + str(calc.turns) + " turns. " + str(calc.TRT) + " effective skill to reduce turns."
		6:
			# pizza
			return "Yummy! Restores 100 energy."
		7:
			# cookies
			return "A snack. Restores 20 energy."
		8:
			# pie
			return "What do you mean 'a proper meal'? Restores 500 energy."
		9:
			# 1 star
			return "Gives 1 Star! Every bit helps."
		10: 
			# 5 star
			return "Gives 5 Stars! You should get as many of these as you can."
		11: 
			# 25 star
			return "Gives a whopping 25 Stars! Feels nice."
		12:
			# key
			return "Goes 'in' a 'lock'. So."
		13:
			# weight
			return "Increases your dexterity by " + str(lvl) + ". Healthy body, healthy mind."
		14:
			# disk
			return "Increases your tech by " + str(lvl) + ". Don't ask what's in it."
		15:
			# book
			return "Increases your clever by " + str(lvl) + ". Also makes shelves pretty."
	
	return ""
