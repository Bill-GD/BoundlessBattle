extends CanvasLayer

var is_upgrading: bool = false

func _ready() -> void:
	connect_ui_signals()
	for child in (get_children() as Array[Control]):
		child.hide()
	$MainMenu.show()

func _input(event: InputEvent) -> void:
	if event.is_pressed() and not event.is_echo():
		if event.is_action("ui_cancel") and $HUD.visible:
			UiController.pause_game.emit()
# 		for testing only
# 		if event.is_action("ui_accept") and $HUD.visible:
# 			UiController.upgrade_menu.emit()

func connect_ui_signals() -> void:
	UiController.start_game.connect(_on_start_game)
	UiController.view_score.connect(_on_view_score)
	UiController.score_to_main_menu.connect(_on_score_to_main_menu)
	UiController.upgrade_menu.connect(_on_upgrade_menu)
	UiController.upgrade_chosen.connect(_on_upgrade_chosen)
	UiController.pause_game.connect(_on_pause_game)
	UiController.unpause_game.connect(_on_unpause_game)
	UiController.pause_to_main_menu.connect(_on_pause_to_main_menu)
	UiController.game_over.connect(_on_game_over)
	UiController.game_over_to_main_menu.connect(_on_game_over_to_main_menu)

func _on_start_game() -> void:
	print('Preparing Game UI')
	$HUD.pause_timer(false)
	$MainMenu.hide()
	$HUD.elapsed_time_seconds = 0
	$HUD.update_time(0)
	$HUD.show()

func _on_view_score() -> void:
	var scores: Array = GameController.get_previous_games()
	print('Displaying scores')
	for s in scores:
		$ScoreMenu.add_score_item(s[0], s[1], s[2], s[3])
	
	$MainMenu.hide()
	$ScoreMenu.show()

func _on_score_to_main_menu() -> void:
	$MainMenu.show()
	$ScoreMenu.hide()

func _on_upgrade_menu() -> void:
	is_upgrading = true
	# also pause game here
	GameController.pause_game()
	$HUD.pause_timer(true)
	$UpgradeMenu.show_menu()

func _on_upgrade_chosen(_upgrade: Upgrade) -> void:
	is_upgrading = false
	$HUD.pause_timer(false)
	GameController.unpause_game()
	$UpgradeMenu.hide()

func _on_pause_game() -> void:
	# also pause game here
	GameController.pause_game()
	$HUD.pause_timer(true)
	$MainMenu.hide()
	$PauseMenu.show()

func _on_unpause_game() -> void:
	if not is_upgrading:
		$HUD.pause_timer(false)
		GameController.unpause_game()
	$PauseMenu.hide()

func _on_pause_to_main_menu() -> void:
	$PauseMenu.hide()
	$HUD.pause_timer(false)
	$HUD.hide()
	$MainMenu.show()
	$UpgradeMenu.hide()
	GameController.set_game_over()

func _on_game_over() -> void:
	$HUD.pause_timer(true)
	$GameOver.show()

func _on_game_over_to_main_menu() -> void:
	$GameOver.hide()
	$HUD.pause_timer(false)
	$HUD.hide()
	$MainMenu.show()
	$UpgradeMenu.hide()
	GameController.set_game_over()
