extends Area2D

var bspeed = 2000
var direction := Vector2.ZERO
var damage: float = 0

func _ready() -> void:
	look_at(direction)
	$Timer.start()

func set_direction(diretion: Vector2):
	direction = diretion.normalized()

func _process(delta: float) -> void:
	if direction != Vector2.ZERO:
		var velocity = direction * bspeed * delta
		global_position += velocity

func _on_screen_exited():
	print_debug("bullet exited screen")
	queue_free()
	
func _on_bullet_body_entered(body: Node2D) -> void:
	if body.is_in_group('enemy'):
		body.handle_hit(damage)
		queue_free()

func _on_timer_timeout():
	queue_free()
