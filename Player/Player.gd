extends KinematicBody2D

var speed = 200.0
var screen_size = Vector2.ZERO
var bullet = load("res://Bullet.tscn")
var laser = load("res://laser.tscn")

var level = 1
export (int) var lives = 3
var dead = false

export (int) var experience
export (int) var experience_total
export (int) var experience_required

var can_fire = true
var attacking = false

var alwaysOn = false
var first_time = true
var canToggle = false
var laserOn = false

#don't know why it is like this
onready var target = position

signal life_lost
signal remove_life
signal hostage_killed

func _ready():
	OS.window_fullscreen = true
	#gets the screen size?
	screen_size = get_viewport_rect().size
	
func _input(event):
	if event.is_action_pressed("shoot"):
		target = get_global_mouse_position()
	if event.is_action_pressed("ui_accept"):
		lose_life()

func _process(delta):
	#basic movement commands
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
		
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
		
	if Input.is_action_pressed("move_down"):
		direction.y += 1
		
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	
	$PC_Sprite.flip_h = direction.x < 0	
	
	if direction.length() > 0:
		direction = direction.normalized()
		
	if direction.x == 0 && direction.y == 0:
		$PC_Sprite.play("idle")
	elif attacking:
		$PC_Sprite.play("cast")
	else:
		$PC_Sprite.play("run")
	move_and_collide(direction * speed * delta)
	#position += direction * speed * delta
	#position.x = clamp(position.x, 0, screen_size.x)
	#position.y = clamp(position.y, 0, screen_size.y)
	
	#Powers start here
	if level == 4:
		alwaysOn = true
	
	if alwaysOn and first_time:
			var l = laser.instance()
			$CollisionShape2D.add_child(l)
			l.alwaysOn = true
			
			l.player_position = self.get_global_position()
			
			l.is_casting = true
			first_time = false
	
	elif !alwaysOn and level == 3:
		if Input.is_action_just_pressed("shoot"):
			
			yield(get_tree().create_timer(0.1), "timeout")
		
			if !laserOn:
				var l = laser.instance()
				self.add_child(l)
				
				l.player_position = self.get_global_position()
				#l.alwaysOn = alwaysOn
				#l.cast_to() = target * 100.0
				#l.rotation = position.angle_to_point(target) + 2.70
				l.is_casting = true
				l.isOn = true
				
	#			if alwaysOn == false && canToggle == false:
	#				yield(get_tree().create_timer(0.25), "timeout")
	#				l.queue_free()
	#				l.is_casting = false
	#			if canToggle == true:
	#				yield(get_tree().create_timer(1), "timeout")
	#				l.queue_free()
	#				l.is_casting = false
				
				laserOn = true

			else:
				laserOn = false
				#print("test")

	#gets the direction to the mouse click
	#position.direction_to(target)
	if Input.is_action_just_pressed("shoot") and can_fire:
		if level <= 2:
			var b = bullet.instance()
			$CollisionShape2D.add_child(b)
			
			attacking = true
			
			b.target = position.direction_to(target)
			b.rotation = position.angle_to_point(target)
			b.playerPos = get_global_position()
			
			b.shoot = true
			can_fire = false
			
			if level == 2:
				b.damage = 2
				yield(get_tree().create_timer(0.25), "timeout")
				can_fire = true
			else:
				yield(get_tree().create_timer(0.5), "timeout")
				can_fire = true

func _on_PC_Sprite_animation_finished():
	attacking = false
	
func _on_Area2D_body_entered(body):
	if(body.is_in_group("BadGuy")):
		lose_life()
	elif(body.is_in_group("Hostages")):
		body.rescue()
	else:
		pass
func _on_Hostage_hostage_killed():
	lives = 0
	emit_signal("hostage_killed")
func lose_life():
	emit_signal("life_lost")
	lives = lives - 1
	if lives == 2:
		pass
	elif lives == 1:
		pass
	elif lives == 0:
		dead = true
		$PC_Sprite.play("death")
		#yield($PC_Sprite.animation, "finished")
		$PC_Sprite.play("death_f")
		#self.queue_free()
