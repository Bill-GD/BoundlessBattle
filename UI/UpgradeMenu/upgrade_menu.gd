extends Control

@export var trans_type: Tween.TransitionType

@onready var card_1: UpgradeCard = $VBox/CardContainer/HBox/UpgradeCard1
@onready var card_2: UpgradeCard = $VBox/CardContainer/HBox/UpgradeCard2
@onready var card_3: UpgradeCard = $VBox/CardContainer/HBox/UpgradeCard3

func show_menu() -> void:
	generate_random_upgrade()
	show()
	move_cards_down()
	$AnimationPlayer.play("start")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "start":
		slide_cards_in()

func generate_random_upgrade() -> void:
	var upgrades: Array[Upgrade] = []
	var has_shotgun: bool = false
	for i in 3:
		var up: Upgrade = Upgrade.get_random_upgrade(has_shotgun)
		has_shotgun = has_shotgun or up.type == Upgrade.UpgradeType.SHOTGUN
		upgrades.append(up)
	
	card_1.set_card_description(upgrades[0])
	card_2.set_card_description(upgrades[1])
	card_3.set_card_description(upgrades[2])
	
func move_cards_down() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(card_1, "position", Vector2(126, 1000), 0)
	tween.tween_property(card_2, "position", Vector2(476, 1000), 0)
	tween.tween_property(card_3, "position", Vector2(826, 1000), 0)

func slide_cards_in() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(card_1, "position", Vector2(126, 0), 0.3).set_trans(trans_type)
	tween.tween_property(card_2, "position", Vector2(476, 0), 0.3).set_trans(trans_type)
	tween.tween_property(card_3, "position", Vector2(826, 0), 0.3).set_trans(trans_type)
