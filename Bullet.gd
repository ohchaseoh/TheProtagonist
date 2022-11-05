extends KinematicBody2D


var shoot = false
var speed = 400.0
onready var target = position


signal enemy_hit


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#set_as_toplevel(true)



func _physics_process(delta): 
	var collision
	if shoot:
		collision = move_and_collide(target * speed * delta)
#		apply_impulse(target, Vector2(0, speed))
	if (collision):
		#print(collision.collider.name)
		var collisionName = collision.collider.name
		if(collisionName == "Follow_BG"):
			#print("Success!")
			emit_signal("enemy_hit")
			self.queue_free()
