extends Control

func _ready() -> void:
	#$AnimationPlayer.play("start")
	pass

func show_menu() -> void:
	show()
	$AnimationPlayer.play("start")

func _on_button_main_menu_pressed() -> void:
	UiController.game_over_to_main_menu.emit()
