extends Control

onready var _label = $ExpBar/LevelText
onready var _bar = $ExpBar/ExperienceBar

signal experience_gained(growth_data)

export (int) var level = 1
var hud_lives = 3

var experience = 0
var experience_total = 0
var experience_required = get_required_experience(level + 1)

func _ready():
	OS.window_fullscreen = true
	
	_label.update_text(level, experience, experience_required)\

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

func _on_Player_life_lost():
	print("hud recieved")
	$HeartBox.visible = false
	hud_lives = hud_lives - 1
	if hud_lives == 2:
		$HeartBox/Heart3.hide()
	elif hud_lives == 1:
		$HeartBox/Heart2.modulate.a = 0.0
	elif hud_lives == 0:
		$HeartBox/Heart1.modulate.a = 0.0
	self.update()
