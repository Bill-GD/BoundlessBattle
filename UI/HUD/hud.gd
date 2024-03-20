extends Control

@onready var time_label: RichTextLabel = $VBox/Margin/HBox/Time
@onready var health_bar: TextureProgressBar = $VBox/Margin/HBox/HealthBar
@onready var health_label: Label = $VBox/Margin/HBox/HealthBar/Label
@onready var armor_bar: TextureProgressBar = $VBox/Margin/HBox/Armorbar
@onready var armor_label: Label = $VBox/Margin/HBox/Armorbar/Label
@onready var kill_label: RichTextLabel = $VBox/HBox/KillCount

var elapsed_time_seconds: float = 0
var is_paused: bool = false

func _ready() -> void:
	UiController.enemy_died.connect(_on_enemy_died)
	GameController.player_hurt.connect(_on_player_hurt)
	UiController.start_game.connect(_on_start_game)

func _on_start_game() -> void:
	print_debug("Prepare HUD")
	update_armor_bar(GameController.player.sheld)
	update_health_bar(GameController.player.hp)
	update_kill_count_label(0)
	update_time(0)
	$Timer.start()

func _on_player_hurt(health: float, armor: float) -> void:
	update_health_bar(health)
	update_armor_bar(armor)

func _on_enemy_died() -> void:
	update_kill_count_label(GameController.kill_count)

func pause_timer(value: bool) -> void:
	$Timer.paused = value

func update_time(new_time: float) -> void:
	time_label.text = '[center]' + str(new_time)

func _on_timer_timeout() -> void:
	elapsed_time_seconds += 1
	update_time(elapsed_time_seconds)

func update_health_bar(new_health: float) -> void:
	health_bar.max_value = round(GameController.player.max_hp)
	health_bar.value = clamp(new_health, 0, health_bar.max_value)
	health_label.text = '%s / %s' % [health_bar.value, health_bar.max_value]

func update_armor_bar(new_armor: float) -> void:
	armor_bar.max_value = round(GameController.player.max_sheld)
	armor_bar.value = clamp(new_armor, 0, armor_bar.max_value)
	armor_label.text = '%s / %s' % [armor_bar.value, armor_bar.max_value]

func update_kill_count_label(kill: int) -> void:
	kill_label.text = '[center]Kills: ' + str(kill)
