extends KinematicBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("idle_anim")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
signal hostage_rescued
signal hostage_killed
func hit(damage):
	#dead hostage sound
	emit_signal("hostage_killed")
	print("Hostage dead")
	#lose game
	self.queue_free()

func rescue():
	#happy hostage sound
	print("Hostage rescued")
	$HostageSound.play()
	$AnimatedSprite.visible = false
	$CollisionShape2D.visible = false
	emit_signal("hostage_rescued")
	self.queue_free()



