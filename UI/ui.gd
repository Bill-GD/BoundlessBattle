extends CanvasLayer

func _ready() -> void:
	connect_ui_signals()
	for child in (get_children() as Array[Control]):
		child.hide()
	$MainMenu.show()

func _input(event: InputEvent) -> void:
	if event.is_pressed() and not event.is_echo():
		if event.is_action("ui_cancel") and $HUD.visible:
			UiController.pause_game.emit()

func connect_ui_signals() -> void:
	UiController.start_game.connect(_on_start_game)
	UiController.view_score.connect(_on_view_score)
	UiController.score_to_main_menu.connect(_on_score_to_main_menu)
	UiController.pause_game.connect(_on_pause_game)
	UiController.unpause_game.connect(_on_unpause_game)
	UiController.pause_to_main_menu.connect(_on_pause_to_main_menu)

func _on_start_game() -> void:
	$MainMenu.hide()
	$HUD.elapsed_time_seconds = 0
	$HUD.update_time(0)
	$HUD.show()

func _on_view_score() -> void:
	$MainMenu.hide()
	$ScoreMenu.show()

func _on_score_to_main_menu() -> void:
	$MainMenu.show()
	$ScoreMenu.hide()

func _on_pause_game() -> void:
	# also pause game here
	$HUD.pause_timer(true)
	$PauseMenu.show()

func _on_unpause_game() -> void:
	$HUD.pause_timer(false)
	$PauseMenu.hide()

func _on_pause_to_main_menu() -> void:
	$PauseMenu.hide()
	$HUD.hide()
	$MainMenu.show()
