extends SubViewportContainer
@onready var score_label: LabelPlus = $SubViewport/Control/TextureRect/ScoreLabel

var max_stars:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().connect("visibility_changed", update_score)
	pass # Replace with function body.

func update_score():
	if(GameManager.PCInstance.STAR > max_stars):
		max_stars = GameManager.PCInstance.STAR
		score_label.text = ("Your score is: " + str(max_stars) + " STARS!\n"
			+ "Thanks for Playing! (lmk your highscore and thoughts in the comments)")
		
