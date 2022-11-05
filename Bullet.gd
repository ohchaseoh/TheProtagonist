extends KinematicBody2D


var shoot = false
var speed = 400.0
onready var target = position


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#set_as_toplevel(true)



func _physics_process(delta):
	if shoot:
		move_and_collide(target * speed * delta)
		
		
#		apply_impulse(target, Vector2(0, speed))
