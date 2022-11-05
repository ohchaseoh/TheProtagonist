extends Node2D

var mat = load("res://Assets/Art/Menu.tres")

var SCREEN_SIZE = Vector2(0,0)

func _ready():
	OS.window_fullscreen = true
	
	SCREEN_SIZE.x = get_viewport().get_visible_rect().size.x # Get Width
	SCREEN_SIZE.y = get_viewport().get_visible_rect().size.y # Get Height
	
func _on_Quit_pressed():
	get_tree().quit()
