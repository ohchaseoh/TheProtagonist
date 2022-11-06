extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isLeft

# Called when the node enters the scene tree for the first time.
func _ready():
	isLeft = true
	$BlockMovingTimer.start()

func _process(delta):
	if isLeft:
		$CenterContainer/Wall1.position.x -= 1
		$CenterContainer/Wall2.position.x += 1
		$CenterContainer/Wall3.position.y += 1
		$CenterContainer/Wall4.position.y -= 1
		$CenterContainer/Wall5.position.y -= 1
	else:
		$CenterContainer/Wall1.position.x += 1
		$CenterContainer/Wall2.position.x -= 1
		$CenterContainer/Wall3.position.y -= 1
		$CenterContainer/Wall4.position.y += 1
		$CenterContainer/Wall5.position.y += 1



func _on_BlockMovingTimer_timeout():
	if(isLeft):
		isLeft = false
	else:
		isLeft = true
