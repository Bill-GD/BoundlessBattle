extends Node

signal start_game
signal player_hurt(health: float, armor: float)
signal player_died
signal enemy_died(global_pos: Vector2)

func get_previous_games() -> Array:
	print('Getting previous games')
	return [
		['name', '54', '56', '1']
	]
