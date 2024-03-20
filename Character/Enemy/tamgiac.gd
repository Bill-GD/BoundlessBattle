extends CharacterBody2D

const SPEED = 300.0
var hp = 50
var atk = 50

func _process(_delta) -> void:
	if is_instance_valid(GameController.player):
		var target_dir: Vector2 = (GameController.player.global_position - global_position)
		velocity = target_dir.normalized() * SPEED
		move_and_slide()

func handle_hit(damage: float):
	print("hit")
	hp -= damage
	if hp <= 0:
		GameController.enemy_died.emit(global_position)
		queue_free()
