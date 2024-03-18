extends Control

func _on_button_play_pressed() -> void:
	UiController.start_game.emit()

func _on_button_score_pressed() -> void:
	UiController.view_score.emit()

func _on_button_exit_pressed() -> void:
	get_tree().quit()
