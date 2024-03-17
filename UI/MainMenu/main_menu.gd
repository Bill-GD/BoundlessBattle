extends Control

func _ready() -> void:
	pass

func _on_button_play_pressed() -> void:
	# emit global signal start_game here
	pass

func _on_button_score_pressed() -> void:
	# emit global signal view_score here
	pass

func _on_button_exit_pressed() -> void:
	get_tree().quit()
