extends Control

var score_item: PackedScene = preload ("res://UI/ScoreMenu/score_display_item.tscn")

func add_score_item(player_name: String, play_time: String, kill_count: String, boss_kill: String) -> void:
	var new_item: Control = score_item.instantiate()
	
	new_item.player_name = player_name
	new_item.play_time = play_time
	new_item.kill_count = kill_count
	new_item.boss_kill = boss_kill
	
	$ScoreContainer/Scroll/VBox.add_child(new_item)

func reset_scoreboard() -> void:
	print('Resetting Scoreboard')
	for child in $ScoreContainer/Scroll/VBox.get_children():
		child.queue_free()

func _on_button_back_pressed() -> void:
	UiController.score_to_main_menu.emit()
	reset_scoreboard()

func _input(event: InputEvent) -> void:
	if event.is_action("ui_cancel") and event.is_pressed() and not event.is_echo():
		reset_scoreboard()
		UiController.score_to_main_menu.emit()
