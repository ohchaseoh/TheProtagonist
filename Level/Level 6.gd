extends Node2D

var isLevel3
var wallArr = []
var wallHealth = []
var hostageCount = 0
# Called when the node enters the scene tree for the first time.
func _ready():
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
		
# Called every frame. 'delta' is the elapsed time since the previous frame.

#func _process(delta):
	
		

func kill_wall(wallID):
	# Gets modulate from the wall that was shot (Color(x,y,z,a))
	var mod = wallArr[wallID].get_modulate()
	# Decrease alpha
	mod.a =- 0.25
	wallArr[wallID].set_modulate(mod)
	# Decrease health
	wallHealth[wallID] -= 25
	# Break wall if health is below 0
	if wallHealth[wallID] <= 0:
		wallArr[wallID].queue_free()

# Receive signal here
func check_wall(wallID):
	if(isLevel3):
		kill_wall(wallID)


func _on_Hostage_hostage_rescued():
	hostageCount = hostageCount - 1


func _on_WinConditionTimer_timeout():
	if hostageCount == 0:
		get_tree().change_scene("res://Level/Level 7.tscn")
