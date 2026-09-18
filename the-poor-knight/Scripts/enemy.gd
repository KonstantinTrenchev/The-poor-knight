extends CharacterBody2D
class_name Enemy
@onready var health_component: Health_Component = $HealthComponent
@onready var ray_cast_left: RayCast2D = $RayCast_LEFT
@onready var ray_cast_right: RayCast2D = $RayCast_RIGHT
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var speed = 60.0
var directions = [-1, 1]
var direction
func _ready() -> void:
	direction = directions[randi() % directions.size()]
	add_to_group("Enemies")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	move_and_slide()
	if  not is_on_floor():
		velocity += get_gravity() * delta
	if !health_component.is_hurt:
		animated_sprite.play("default")
	if ray_cast_left.is_colliding():
		direction=1
		animated_sprite.flip_h = false
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if direction:
		position.x += direction * speed * delta
	


func _on_health_component_dead() -> void:
	queue_free()
