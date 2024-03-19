extends CharacterBody2D


var hp = 100
var sheld = 100
var speed = 500
var accel = 1500
var friction = 500
var input = Vector2.ZERO
const bullet = preload("res://player/bullet.tscn")

@onready var atkcd = $atkcd
@onready var gun = $gun

	
# Get the gravity from the project settings to be synced with RigidBody nodes.



func _physics_process(delta):
	player_move(delta)
	look_at(get_global_mouse_position())
	
func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return input.normalized()
	
	
func player_move(delta):
	input = get_input()
	
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (accel * input * delta)
		velocity = velocity.limit_length(speed)
	move_and_slide()
	
	
func _unhandled_input(event: InputEvent) -> void:	
	if event.is_action_released("shoot"):
		shoot()  
	
func shoot():
	if atkcd.is_stopped():
		var bullet_instantiante = bullet.instantiate()
		add_child(bullet_instantiante)
		bullet_instantiante.global_position = $gun.global_position
		var vect = get_global_mouse_position() - bullet_instantiante.global_position
		bullet_instantiante.set_direction(vect)
		atkcd.start()
	
func handle_hit():
	hp -= 20
	queue_free()
