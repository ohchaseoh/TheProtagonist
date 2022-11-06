extends Node2D

onready var _click = $SFX_ButtonClick
onready var _hover = $SFX_ButtonHover

var mat = load("res://Assets/Art/Menu.tres")

var SCREEN_SIZE = Vector2(0,0)

func _ready():
	OS.window_fullscreen = true
	
	$TransitionScreen.visible = false
	

	AutoloadController.play_menu_music()

	
	_click.volume_db = 2.0

func _on_Start_mouse_entered():
	_hover.play()

func _on_Start_pressed():
	_click.play()
	AutoloadController.play_va()
	
	$TransitionScreen.visible = true
	$TransitionScreen.transition()

func _on_TransitionScreen_transitioned():
	get_tree().change_scene("res://Menu/PowerSelect.tscn")
	
func _on_Options_mouse_entered():
	_hover.play()
	
func _on_Options_pressed():
	_click.play()
	
func _on_Quit_mouse_entered():
	_hover.play()

func _on_Quit_pressed():
	_click.play()
	get_tree().quit()
