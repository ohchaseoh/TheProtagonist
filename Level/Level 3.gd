extends Node2D

#new comment
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isUp
var isDoubleUp
var isLevel3
var wallArr = []
var wallHealth = []
var hostageCount = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	isUp = true
	isDoubleUp = true
	$BlockMovingTimer.start()
	$WinConditionTimer.start()
	OS.window_fullscreen = true
	isLevel3 = false
	var mod = $Sprite.get_modulate()
	mod.a = 0.5
	$Sprite.set_modulate(mod)
	for i in $Transform/CenterContainer.get_children():
		if "Wall" in i.get_name():
			#print(i.get_name())
			wallArr.append(i)
			wallHealth.append(100)
	for i in self.get_children():
		if "Hostage" in i.get_name():
			hostageCount = hostageCount + 1

	
func _process(delta):
	if isUp:
		$Transform/CenterContainer/Wall2.position.y -= 0.5
	else:
		$Transform/CenterContainer/Wall2.position.y += 0.5

func _on_BlockMovingTimer_timeout():
	if isUp:
		isUp = false;
	else:
		isUp = true
func _on_Hostage_hostage_rescued():
	hostageCount = hostageCount - 1


func _on_WinConditionTimer_timeout():
	if hostageCount == 0:
		get_tree().change_scene("res://Level/Level 4.tscn")
	if $Player.lives == 0:
		get_tree().change_scene("res://Level/Level 3.tscn")



func _on_Hostage_hostage_killed():
	get_tree().change_scene("res://Level/Level 3.tscn")
