extends KinematicBody2D

var motion = Vector2()
var health = 15
onready var anim_sprite = $AnimatedSprite

signal charge_bg_die

# Called when the node enters the scene tree for the first time.
func _ready():
	#target = get_parent().get_node("Player").position
	anim_sprite.play("idle_anim")

func _physics_process(delta):
	pass

func hit(damage):
	if(health < damage):
		health = 0
		#dead BadGuy sound
		
		print("Enemy dead")
		self.queue_free()
	else:
		health = health - damage
		#hurt BadGuy sound
		print("Enemy hit")
		

