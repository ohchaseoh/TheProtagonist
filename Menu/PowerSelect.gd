extends Node2D

var timer

func _ready():
	
	OS.window_fullscreen = true
	$TransitionScreen/AnimationPlayer.play("fade_to_normal")
	
	timer = get_tree().create_timer(7)
	yield(timer, "timeout")
	AutoloadController.stop_va()

func _on_LaserStart_pressed():
	get_tree().change_scene("res://Level/Level 1.tscn")
