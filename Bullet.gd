extends KinematicBody2D


onready var enemy = get_node("res://BadGuy/Follow_BG/Follow_BG.tscn")
var shoot = false
var speed = 400.0
onready var target = position
var damage = 1


signal enemy_hit(damage,enemy)


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
		#var collisionType = collision.collider.get_class()
		#if(collisionType == "KinematicBody2D"):
		collision.get_collider().hit(damage)
		self.queue_free()
