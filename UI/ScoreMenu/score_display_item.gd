extends Control

var player_name: String = 'Name'
var play_time: String = 'Time'
var kill_count: String = 'Kill'
var boss_kill: String = 'Boss'

func _ready() -> void:
	$HBoxContainer/Name.text = player_name
	$HBoxContainer/Time.text = play_time
	$HBoxContainer/Kill.text = kill_count
	$HBoxContainer/Boss.text = boss_kill
