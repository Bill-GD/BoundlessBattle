extends CharacterBody2D

const SPEED = 200.0
var hp = 100
var atk = 20

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
