extends Node2D

func _ready():
	$TransitionScreen/AnimationPlayer.play("fade_to_normal")
	OS.window_fullscreen = true
