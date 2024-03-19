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

func _init(upgrade_type: UpgradeType, stat: float) -> void:
	type = upgrade_type
	description = type_desc[upgrade_type]
	up_stat = stat

func get_upgrade_info() -> Dictionary:
	return {
		"type": upgrade_types[type],
		"desc": description,
		"up_stat": "[center]" + get_upgrade_stat_desc(),
	}

func get_upgrade_stat_desc() -> String:
	if type == UpgradeType.SHOTGUN:
		return stat_desc[type]
	else:
		return stat_desc[type] + "[color=red]" + str(up_stat).substr(0, 1) + "%"

static func get_random_upgrade(exclude_shotgun: bool=false) -> Upgrade:
	var index: int
	if exclude_shotgun:
		index = randi_range(0, 3)
	else:
		index = randi_range(0, 4)
	return Upgrade.new(UpgradeType.values()[index], randf_range(1, 5))
