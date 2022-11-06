extends KinematicBody2D

var motion = Vector2()
var health = 5

onready var anim_sprite = $AnimatedSprite

signal follow_bg_die

# Called when the node enters the scene tree for the first time.
func _ready():
	#OS.window_fullscreen = true
	pass

func _physics_process(delta):
	anim_sprite.play("run_anim")
	
	if(get_parent().get_node("Player")):
		var Player = get_parent().get_node("Player")
		position += (Player.position - position)/50
		look_at(Player.position)
		move_and_collide(motion)
	else:
		print("You Lose!")

func hit(damage):
	if(health < damage):
		health = 0
		#dead BadGuy sound
		emit_signal("follow_bg_die")
		print("Enemy dead")
		self.queue_free()
	else:
		health = health - damage
		#hurt BadGuy sound
		print("Enemy hit")
		
