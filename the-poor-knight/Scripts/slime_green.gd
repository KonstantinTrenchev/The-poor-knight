extends Node2D
@export var speed = 60
@onready var health_component: Health_Component = $HealthComponent
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var directions = [-1, 1]
var direction
# Called when the node enters the scene tree for the first time.


func _ready() -> void:
	direction = directions[randi() % directions.size()]
	add_to_group("Enemies")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_left.is_colliding():
		direction=1
		animated_sprite.flip_h = false
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	position.x+= direction*delta*speed
	


func _on_health_component_dead() -> void:
	queue_free()
	remove_from_group("Enemies")


func _on_health_component_health_changed(_new_amount: Variant) -> void:
		position.x+= speed /4.0
		speed = 0
