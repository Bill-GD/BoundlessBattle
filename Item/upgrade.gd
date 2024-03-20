class_name Upgrade

enum UpgradeType {
	HEALTH,
	DAMAGE,
	SPEED,
	ARMOR,
	SHOTGUN,
}

static var type_desc: Dictionary = {
	UpgradeType.HEALTH: "Increase your health to avoid death when fighting your enemies.",
	UpgradeType.DAMAGE: "Increase your damage to better battle against your enemies.",
	UpgradeType.SPEED: "Increase your speed to better avoid your enemies.",
	UpgradeType.ARMOR: "Increase your armor to better defense against your enemies.",
	UpgradeType.SHOTGUN: "Add another option to annihilate your enemies.",
}

static var stat_desc: Dictionary = {
	UpgradeType.HEALTH: "Increases health by ",
	UpgradeType.DAMAGE: "Increases damage by ",
	UpgradeType.SPEED: "Increases speed by ",
	UpgradeType.ARMOR: "Increases armor by ",
	UpgradeType.SHOTGUN: "Add a Shotgun to your arsenal.",
}

# a static array of type Array[String] for UpgradeType names
static var upgrade_types: Array[String] = [
	"HEALTH",
	"DAMAGE",
	"SPEED",
	"ARMOR",
	"SHOTGUN",
]

var type: UpgradeType
var description: String
var up_stat: float
var cur_stat: String

func _init(upgrade_type: UpgradeType, stat: float) -> void:
	type = upgrade_type
	description = type_desc[upgrade_type]
	up_stat = stat
	match upgrade_type:
		UpgradeType.HEALTH:
			cur_stat = "%.1f > [color=darkgreen]%.1f" % [GameController.player.max_hp, (GameController.player.max_hp * (1 + up_stat / 100))]
		UpgradeType.DAMAGE:
			cur_stat = "%.1f > [color=darkgreen]%.1f" % [GameController.player.atk, (GameController.player.atk * (1 + up_stat / 100))]
		UpgradeType.SPEED:
			cur_stat = "%.1f > [color=darkgreen]%.1f" % [GameController.player.speed, (GameController.player.speed * (1 + up_stat / 100))]
		UpgradeType.ARMOR:
			cur_stat = "%.1f > [color=darkgreen]%.1f" % [GameController.player.max_sheld, (GameController.player.max_sheld * (1 + up_stat / 100))]
		UpgradeType.SHOTGUN:
			cur_stat = "Shotgun: "

func get_upgrade_info() -> Dictionary:
	return {
		"type": upgrade_types[type],
		"desc": description,
		"up_stat": "[center]" + get_upgrade_stat_desc(),
		"cur_stat": "[center]" + cur_stat,
	}

func get_upgrade_stat_desc() -> String:
	if type == UpgradeType.SHOTGUN:
		return stat_desc[type]
	else:
		return stat_desc[type] + ("[color=red] %.0f" % up_stat) + "%"

static func get_random_upgrade(exclude_shotgun: bool=false) -> Upgrade:
	var index: int
	# if exclude_shotgun:
	index = randi_range(0, 3)
	# else:
	# 	index = randi_range(0, 4)
	return Upgrade.new(UpgradeType.values()[index], randf_range(5, 15))
