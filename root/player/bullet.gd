extends Area2D

var bspeed = 2000
var direction := Vector2.ZERO

func set_direction(diretion: Vector2):
	self.direction = direction

func _process(delta: float) -> void:
	if direction != Vector2.ZERO:
		var velocity = direction * bspeed *delta
		global_position += velocity
func _on_screen_exited():
	queue_free()
	
func _on_bullet_body_entered(body: Node) -> void :
	if body.has_method("handle_hit"):
		body.handle_hit()


