extends Node

signal start_game
signal player_hurt(health: float, armor: float)
signal player_died
signal enemy_died(global_pos: Vector2)

var player = null
var kill_count: int = 0

func get_previous_games() -> Array:
	print('Getting previous games')
	return [
		['name', '54', '56', '1']
	]

func pause_game() -> void:
	player.set_physics_process(false)
	get_tree().call_group('enemy', 'set_process', false)

func unpause_game() -> void:
	player.set_physics_process(true)
	get_tree().call_group('enemy', 'set_process', true)

func set_game_over() -> void:
	get_tree().call_group('enemy', 'queue_free')
	get_tree().call_group('item', 'queue_free')
	if player:
		player.queue_free()
	player = null
