extends Label
class_name LabelPlus

var original_width
var original_text_size

func _ready() -> void:
	original_width = size.x
	original_text_size = label_settings.font_size
	
	item_rect_changed.connect(_reevaluate_size)
	pass

func text_set(value: String) -> void:
	
	set_text(value)
	
	pass

func _reevaluate_size() -> void:
	var ratio:float
	
	ratio = original_width/size.x
	
	label_settings.font_size = original_text_size*ratio
	
	size.x = original_width
