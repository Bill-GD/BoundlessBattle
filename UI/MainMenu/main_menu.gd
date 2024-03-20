extends Control

func _on_button_play_pressed() -> void:
	print('Button play pressed')
	GameController.start_game.emit()
	UiController.start_game.emit()

func _on_button_score_pressed() -> void:
	print('Button score pressed')
	UiController.view_score.emit()

func _on_button_exit_pressed() -> void:
	print('Exiting game')
	get_tree().quit()
