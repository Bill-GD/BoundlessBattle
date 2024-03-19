extends CharacterBody2D

const SPEED = 500.0
var hp = 50
var atk = 70

func handle_hit():
	hp -= 20
	if hp <= 0:
		queue_free()
