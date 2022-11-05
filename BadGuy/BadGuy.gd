extends KinematicBody2D


var motion = Vector2()
var health = 5
onready var anim_sprite = $AnimatedSprite


# Called when the node enters the scene tree for the first time.
func _ready():
	#OS.window_fullscreen = true
	pass


func _physics_process(delta):
	anim_sprite.play("run_anim")
	var Player = get_parent().get_node("Player")
	
	position += (Player.position - position)/50
	look_at(Player.position)
	
	move_and_collide(motion)


func _on_Bullet_enemy_hit():
	#print("Success!")
	if(health == 1):
		self.queue_free()
		print("Enemy dead")
	else:
		health = health - 1
		print("Enemy hit")



