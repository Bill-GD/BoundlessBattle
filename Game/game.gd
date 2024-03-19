extends Node2D

var player_scene: PackedScene
var enemy_scene: PackedScene

var enemy_count: int = 0
var max_enemy: int = 10

var kill_count: int = 0
var boss_kill_count: int = 0

func _ready() -> void:
	GameController.start_game.connect(_on_start_game)
	GameController.player_died.connect(_on_player_died)
	GameController.enemy_died.connect(_on_enemy_died)

func _on_start_game() -> void:
	print('Preparing Game')
	kill_count = 0
	boss_kill_count = 0

func _on_enemy_died(global_pos: Vector2) -> void:
	# add kill
	kill_count += 1

func _on_player_died() -> void:
	UiController.game_over.emit()
	# disable player movement

func spawn_enemy() -> void:
	pass
