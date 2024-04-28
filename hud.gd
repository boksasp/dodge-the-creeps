extends CanvasLayer

signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	await $MessageTimer.timeout
	
	$Message.text = "Dodge the Creeps!"
	$Message.show()
	
	await get_tree().create_timer(1.0).timeout
	$GameSettingMenu.show()
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func emit_start_game():
	$StartButton.hide()
	start_game.emit()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	emit_start_game()

func _on_message_timer_timeout():
	$Message.hide()

func _unhandled_key_input(event):
	if $StartButton.is_visible_in_tree() and event.is_action_pressed("ui_text_submit"):
		emit_start_game()
