extends Control

func _ready():
	pass

func _on_button_play_pressed():
	# emit global signal start_game here
	pass

func _on_button_score_pressed():
	# emit global signal view_score here
	pass

func _on_button_exit_pressed():
	get_tree().quit()
