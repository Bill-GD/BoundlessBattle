extends Control

func _ready() -> void:
	hide()
	#$AnimationPlayer.play("start")

func show_menu() -> void:
	show()
	$AnimationPlayer.play("start")

func _on_button_main_menu_pressed() -> void:
	# back to main menu
	pass
