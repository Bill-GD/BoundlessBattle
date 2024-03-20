extends Node2D

var player_scene: PackedScene = preload ("res://Character/Player/player_square.tscn")
var enemy_scenes: Array[PackedScene] = [
	preload ("res://Character/Enemy/enemy_circle.tscn"),
	preload ("res://Character/Enemy/enemy_tamgiac.tscn"),
	preload ("res://Character/Enemy/enemy_vuong.tscn")
]
var item_scene: PackedScene = preload ("res://Item/item.tscn")

var enemy_count: int = 0
var max_enemy: int = 10

var player_alive: bool = false

func _ready() -> void:
	GameController.start_game.connect(_on_start_game)
	GameController.player_died.connect(_on_player_died)
	GameController.enemy_died.connect(_on_enemy_died)

	UiController.pause_game.connect(_on_pause_game)
	UiController.unpause_game.connect(_on_unpause_game)

func _on_pause_game() -> void:
	$EnemySpawnTimer.paused = true

func _on_unpause_game() -> void:
	$EnemySpawnTimer.paused = false

func _on_start_game() -> void:
	print('Preparing Game')
	$EnemySpawnTimer.paused = false
	GameController.kill_count = 0
	enemy_count = 0
	player_alive = true
	add_child(player_scene.instantiate())

	GameController.player = $player_square
	$EnemySpawnTimer.start()
	spawn_enemy()

func _on_enemy_died(death_pos: Vector2) -> void:
	GameController.kill_count += 1
	UiController.enemy_died.emit()
	enemy_count -= 1
	# add item at death_pos
	var item = item_scene.instantiate()
	item.global_position = death_pos
	add_child(item)
	$EnemySpawnTimer.start()
	spawn_enemy()

func _on_player_died() -> void:
	player_alive = false
	UiController.game_over.emit()
	GameController.set_game_over()
	$EnemySpawnTimer.stop()

func spawn_enemy() -> void:
	var player_local_pos: Vector2 = GameController.player.to_local(GameController.player.global_position)

	print('Spawning enemies')
	while enemy_count < max_enemy:
		await $EnemySpawnTimer.timeout
		if not player_alive: break
		var ran_pos: Vector2 = (player_local_pos + Vector2(randf_range( - 1, 1), randf_range( - 1, 1))).normalized() * 600
		enemy_count += 1
		var enemy = enemy_scenes.pick_random().instantiate()
		enemy.global_position = to_global(ran_pos)
		add_child(enemy)
		print('Enemy count: ' + str(enemy_count))
		$EnemySpawnTimer.start()
