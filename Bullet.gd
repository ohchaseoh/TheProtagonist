extends KinematicBody2D


var shoot = false
var speed = 400.0
onready var target = position
onready var playerPos = position
var firstTime = true
var damage = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_toplevel(true)
	


func _physics_process(delta):
	var collision
	
	if shoot:
		
		if firstTime:
			self.position = playerPos
			firstTime = false
			
		else:
			collision = move_and_collide(target * speed * delta)
			if(collision):
				if(collision.get_collider().is_in_group("Walls")):
					self.queue_free()
				else:
					collision.get_collider().hit(damage)
					self.queue_free()
		
#		apply_impulse(target, Vector2(0, speed))
