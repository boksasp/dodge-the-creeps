extends OptionButton

signal easy_mode_selected
signal medium_mode_selected
signal hard_mode_selected

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_item_selected(index):
	if index == 0:
		easy_mode_selected.emit()
	elif index == 1:
		medium_mode_selected.emit()
	elif index == 2:
		hard_mode_selected.emit()
