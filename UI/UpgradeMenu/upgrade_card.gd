class_name UpgradeCard
extends MarginContainer

@export_range(0, 1, 0.05, "or_greater") var scale_factor: float = 1.25

@onready var type: Label = $Button/MarginContainer/VBoxContainer/Type
@onready var up_stat: RichTextLabel = $Button/MarginContainer/VBoxContainer/UpgradeStat
@onready var desc: Label = $Button/MarginContainer/VBoxContainer/Description
@onready var cur_stat: RichTextLabel = $Button/MarginContainer/VBoxContainer/CurrentStat

var upgrade_item: Upgrade
var tween: Tween

func _ready() -> void:
	pivot_offset = size / 2

## Set the card info based on the Upgrade obj
func set_card_description(upgrade: Upgrade) -> void:
	var info: Dictionary = upgrade.get_upgrade_info()
	upgrade_item = upgrade

	type.text = info["type"]
	up_stat.text = info["up_stat"]
	desc.text = info["desc"]
	cur_stat.text = info["cur_stat"]

func _on_button_pressed() -> void:
	# Apply upgrade to player here
	print_rich("[color=green]Selected upgrade: %s" % name)
	UiController.upgrade_chosen.emit(upgrade_item)
	GameController.player.apply_upgrade(upgrade_item)

func _on_button_mouse_entered() -> void:
	tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(scale_factor, scale_factor), 0.3).set_trans(Tween.TRANS_QUAD)

func _on_button_mouse_exited() -> void:
	tween.pause() # stop even if enter not finished
	
	tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 0.2).set_trans(Tween.TRANS_SINE)
