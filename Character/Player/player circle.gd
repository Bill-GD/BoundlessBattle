extends CharacterBody2D

var hp = 100
var max_hp = 100
var sheld = 100
var max_sheld = 100
var atk = 10
var speed = 500
var accel = 1500
var friction = 500
const bullet = preload ("res://Character/Player/bullet.tscn")

@onready var atkcd = $atkcd
@onready var gun = $gun

func _ready() -> void:
	pass

func _physics_process(delta):
	player_move(delta)
	look_at(get_global_mouse_position())
	
	var collision = get_last_slide_collision()
	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group("enemy"):
			handle_hit(collider.atk)
	
	if Input.is_action_pressed("shoot"):
		shoot()
	
func player_move(delta):
	var input: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (accel * input * delta)
		velocity = velocity.limit_length(speed)
	move_and_slide()
	
func shoot():
	if atkcd.is_stopped():
		var bullet_instantiante = bullet.instantiate()
		bullet_instantiante.global_position = $gun.global_position
		var vect = get_global_mouse_position() - global_position
		bullet_instantiante.set_direction(vect)
		bullet_instantiante.damage = atk
		get_tree().root.add_child(bullet_instantiante)
		atkcd.start()

func apply_upgrade(up: Upgrade) -> void:
	match up.type:
		Upgrade.UpgradeType.HEALTH:
			var old = max_hp
			max_hp *= (1 + up.up_stat / 100)
			hp += max_hp - old
		Upgrade.UpgradeType.DAMAGE:
			atk *= (1 + up.up_stat / 100)
		Upgrade.UpgradeType.SPEED:
			speed *= (1 + up.up_stat / 100)
		Upgrade.UpgradeType.ARMOR:
			var old = max_sheld
			max_sheld *= (1 + up.up_stat / 100)
			sheld += max_sheld - old
	GameController.player_hurt.emit(hp, sheld)
	
func handle_hit(damage: float) -> void:
	if not $HurtCD.is_stopped(): return

	print(str("player is hit,", damage))
	if sheld > 0:
		sheld -= damage
		if sheld <= 0: sheld = 0
	else:
		hp -= damage
	GameController.player_hurt.emit(hp, sheld)
	$HurtCD.start()
	if hp <= 0:
		GameController.player_died.emit()
	$ArmorCD.start()
	$ArmorRegen.stop()

func _on_armor_cd_timeout():
	print("Start armor regen")
	$ArmorRegen.start()

func _on_armor_regen_timeout():
	sheld += 1
	if sheld >= max_sheld:
		print("Armor full")
		sheld = max_sheld
		$ArmorRegen.stop()
		GameController.player_hurt.emit(hp, sheld)
		return
	$ArmorRegen.start()
	GameController.player_hurt.emit(hp, sheld)
