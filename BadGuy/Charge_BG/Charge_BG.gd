extends KinematicBody2D


var motion = Vector2()
var health = 15
onready var anim_sprite = $AnimatedSprite


#if(get_parent().get_node("Player")):
var target 


# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_parent().get_node("Player").position
	anim_sprite.play("idle_anim")


func _physics_process(delta):
	pass


func _on_Timer_timeout():
	pass
