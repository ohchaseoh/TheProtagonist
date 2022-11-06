extends KinematicBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("idle_anim")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func hit(damage):
	#dead hostage sound
	print("Hostage dead")
	#lose game
	self.queue_free()

func rescue():
	#happy hostage sound
	print("Hostage rescued")
	self.queue_free()
