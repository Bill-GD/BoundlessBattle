class_name Item
extends Area2D

func _ready():
	$AnimationPlayer.play("floating")

func _on_body_entered(body: PhysicsBody2D):
	if body.is_in_group('enemy'): return
	# if body is player, pick up item
	# show upgrade menu
	UiController.upgrade_menu.emit()
	queue_free()
