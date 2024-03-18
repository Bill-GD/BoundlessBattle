extends Control

var score_item: PackedScene = preload("res://UI/ScoreMenu/score_display_item.tscn")

func _ready() -> void:
	hide()

func add_score_item(player_name: String, play_time: String, kill_count: int, boss_kill: int) -> void:
	var new_item: Control = score_item.instantiate()
	
	new_item.player_name = player_name
	new_item.play_time = play_time
	new_item.kill_count = str(kill_count)
	new_item.boss_kill = str(boss_kill)
	
	$ScoreContainer/Scroll/VBox.add_child(new_item)

func _on_button_back_pressed() -> void:
	# return to main menu
	pass
