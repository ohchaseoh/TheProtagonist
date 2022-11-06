extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isUp
var isDoubleUp

# Called when the node enters the scene tree for the first time.
func _ready():
	isUp = true
	isDoubleUp = true
	$BlockMovingTimer.start()

	
func _process(delta):
	if isUp:
		$CenterContainer/Wall2.position.y -= 0.5
	else:
		$CenterContainer/Wall2.position.y += 0.5

func _on_BlockMovingTimer_timeout():
	if isUp:
		isUp = false;
	else:
		isUp = true

