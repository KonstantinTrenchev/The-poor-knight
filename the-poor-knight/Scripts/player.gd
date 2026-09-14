class_name Player
extends CharacterBody2D
@onready var health_component: Health_Component = $Health_Component
@onready var jumping_box: Hitbox = $JumpingBox
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
const SPEED = 150.0
const JUMP_VELOCITY = -400.0
var last_save_position
@export var  kill_jump:bool
func _ready() -> void:
	add_to_group("Player")
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor():
		last_save_position = global_position
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if direction <0:
			animated_sprite_2d.flip_h = true
		else :
			animated_sprite_2d.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()



func _on_health_component_dead() -> void:
	health_component.current_health=health_component.max_health
	get_tree().call_deferred("reload_current_scene")
	print("You dead.")


func _on_health_component_health_changed(_new_amount: Variant) -> void:
		global_position = last_save_position
	
