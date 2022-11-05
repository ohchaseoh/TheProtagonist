extends Control

onready var _label = $ExpBar/LevelText
onready var _bar = $ExpBar/ExperienceBar

signal experience_gained(growth_data)

export (int) var level = 1

var experience = 0
var experience_total = 0
var experience_required = get_required_experience(level + 1)

func _ready():
	OS.window_fullscreen = true
	
	_label.update_text(level, experience, experience_required)
	
func _input(event):
	if not event.is_action_pressed("ui_accept"):
		return
	gain_experience(50)
	_label.update_text(level, experience, experience_required)
	

func get_required_experience(level):
	return round(pow(level, 1.8) + level * 4)

func gain_experience(amount):
	experience_total += amount
	experience += amount
	
	var growth_data = []
	
	if experience >= experience_required:
		experience -= experience_required
		growth_data.append([experience_required, experience_required])
		level_up()
	growth_data.append([experience, experience_required])
	emit_signal("experience_gained", growth_data)
		
func level_up():
	level += 1
	experience_required = get_required_experience(level + 1)
