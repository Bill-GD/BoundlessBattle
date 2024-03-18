extends Control

@onready var time_label: RichTextLabel = $VBox/Margin/HBox/Time
@onready var health_bar: TextureProgressBar = $VBox/Margin/HBox/HealthBar
@onready var health_label: Label = $VBox/Margin/HBox/HealthBar/Label
@onready var armor_bar: TextureProgressBar = $VBox/Margin/HBox/Armorbar
@onready var armor_label: Label = $VBox/Margin/HBox/Armorbar/Label
@onready var kill_label: RichTextLabel = $VBox/HBox/KillCount
@onready var boss_label: RichTextLabel = $VBox/HBox/BossKill

var elapsed_time_seconds: float = 0
var is_paused: bool = false

func _ready() -> void:
	update_time(0)
	update_armor_bar(50)
	update_health_bar(30)
	update_kill_count_label(4, 1)
	$Timer.start()

func pause_timer(value: bool) -> void:
	$Timer.paused = value

func update_time(new_time: float) -> void:
	time_label.text = '[center]' + str(new_time)

func _on_timer_timeout() -> void:
	elapsed_time_seconds += 1
	update_time(elapsed_time_seconds)

func update_health_bar(new_health: float) -> void:
	health_bar.value = clamp(new_health, 0, health_bar.max_value)
	health_label.text = '%s / %s' % [health_bar.value, health_bar.max_value]

func update_armor_bar(new_armor: float) -> void:
	armor_bar.value = clamp(new_armor, 0, armor_bar.max_value)
	armor_label.text = '%s / %s' % [armor_bar.value, armor_bar.max_value]

func update_kill_count_label(kill: int, boss_kill: int) -> void:
	kill_label.text = '[right]Kills: ' + str(kill)
	boss_label.text = 'Boss: ' + str(boss_kill)
