extends Node

func _ready():
	OS.window_fullscreen = true
	
	$HUD.visible = false
	$Player.visible = false
