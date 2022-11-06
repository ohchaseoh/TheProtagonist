extends Node2D

onready var _click = $SFX_ButtonClick
onready var _hover = $SFX_ButtonHover

var mat = load("res://Assets/Art/Menu.tres")

var SCREEN_SIZE = Vector2(0,0)

func _ready():
	OS.window_fullscreen = true
	
	_click.volume_db = 2.0
	
	SCREEN_SIZE.x = get_viewport().get_visible_rect().size.x # Get Width
	SCREEN_SIZE.y = get_viewport().get_visible_rect().size.y # Get Height

func _on_Start_mouse_entered():
	_hover.play()

func _on_Start_pressed():
	_click.play()
	
func _on_Options_mouse_entered():
	_hover.play()
	
func _on_Options_pressed():
	_click.play()
	
func _on_Quit_mouse_entered():
	_hover.play()

func _on_Quit_pressed():
	_click.play()
	get_tree().quit()
