extends CharacterBody2D

const SPEED = 300.0
var hp = 200
var atk = 10

func handle_hit():
	hp -= 20
	if hp <= 0:
		queue_free()
