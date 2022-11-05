extends KinematicBody2D


var shoot = false
var speed = 400.0
onready var target = position
var damage = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#set_as_toplevel(true)


func _physics_process(delta):
	var collision
	if shoot:
		collision = move_and_collide(target * speed * delta)
		if(collision):
			collision.get_collider().hit(damage)
			self.queue_free()
		
#		apply_impulse(target, Vector2(0, speed))
