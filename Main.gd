extends Node

onready var _hud = $HUD

func _ready():
	OS.window_fullscreen = true
	
	$HUD.visible = false
	$Player.visible = false

func _on_Follow_BG_follow_bg_die():
	_hud.gain_experience(25)
	_hud.update()

func _on_Charge_BG_charge_bg_die():
	_hud.gain_experience(40)
	_hud.update()
