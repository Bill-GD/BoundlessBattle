extends CharacterBody2D

const SPEED = 300.0
var hp = 100
var atk = 20

func handle_hit():
	hp -= 20
	if hp <= 0:
		queue_free()
