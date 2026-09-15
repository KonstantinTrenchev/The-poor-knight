class_name Player
extends CharacterBody2D
@onready var health_component: Health_Component = $Health_Component
@onready var jumping_box: Hitbox = $JumpingBox
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var dead_timer: Timer = $DeadTimer
const SPEED = 150.0
const JUMP_VELOCITY = -400.0
var last_save_position
@export var  kill_jump:bool
func _ready() -> void:
	add_to_group("Player")
	health_component.current_health = health_component.max_health
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor():
		last_save_position = global_position
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if animated_sprite_2d.is_playing() != true:
		if is_on_floor():
			if direction == 0:
				animated_sprite_2d.play("idle")
			else :
				animated_sprite_2d.play("run")
		else:
			animated_sprite_2d.play("jump")
	if direction:
		velocity.x = direction * SPEED
		if direction <0:
			animated_sprite_2d.flip_h = true
		elif direction > 0 :
			animated_sprite_2d.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()



func _on_health_component_dead() -> void:
	print("You dead.")
	get_tree().call_deferred("reload_current_scene")

	

func _on_health_component_health_changed(_new_amount: Variant) -> void:
		global_position = last_save_position
	
