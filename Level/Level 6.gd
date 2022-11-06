extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var color

# Called when the node enters the scene tree for the first time.
func _ready():
	var newMaterial = SpatialMaterial.new()
	#color = Color(155, 155, 155, 255)
	newMaterial.albedo_color = Color(128, 128, 128, 1.0)
	$CenterContainer/Wall1/MeshInstance2D.material = newMaterial
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
