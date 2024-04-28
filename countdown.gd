extends Label

var time_left = 0.0

func _on_message_timer_timeout():
	hide()
	
func _ready():
	hide()

func _process(delta):
	if visible:
		time_left += delta
		text = "%.1f" % time_left

func _on_hud_start_game():
	time_left = -2.0
	show()
