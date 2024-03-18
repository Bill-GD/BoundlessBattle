extends Control

# Pause menu, only control buttons
# Actual pause/unpause in UI controller (event autoload)

func _on_button_continue_pressed() -> void:
	UiController.unpause_game.emit()

func _on_button_main_menu_pressed() -> void:
	UiController.pause_to_main_menu.emit()
