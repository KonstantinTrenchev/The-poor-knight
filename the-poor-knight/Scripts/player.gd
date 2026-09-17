extends CharacterBody2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurtbox_component: Hurtbox_Component = $Hurtbox_Component
@onready var health_component: Health_Component = $Health_Component
@onready var jump_cast: RayCast2D = $Jump_cast
@onready var jumping_hit_box_down: Hitbox = $JumpingHitBox_DOWN
@onready var jumping_hit_box_up: Hitbox = $JumpingHitBox_UP
@export var  speed = 150
@export var  default_speed = 150
var  jump_velocity = -400.0
var last_save_position
var  play_loops = true
@export var  kill_jump:bool

func _ready() -> void:
	add_to_group("Player")
	health_component.current_health = health_component.max_health
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if !jump_cast.is_colliding():
		velocity += get_gravity() * delta
	if jump_cast.is_colliding():
		last_save_position = global_position

	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_cast.is_colliding():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if !health_component.is_hurt:
		if jump_cast.is_colliding():
			if direction == 0:
				animated_sprite.play("idle")
			else :
				animated_sprite.play("run")
		else:
			animated_sprite.play("jump")
		if direction:
			velocity.x = direction * speed
			if direction <0:
				animated_sprite.flip_h = true
			elif direction > 0 :
				animated_sprite.flip_h = false
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
	if Input.is_action_pressed("sprint"):
		speed = default_speed * 2
	else:
		speed = default_speed
	move_and_slide()


func _on_health_component_dead() -> void:
	get_tree().call_deferred("reload_current_scene")


func _on_health_component_health_changed(_new_amount: Variant) -> void:
	global_position = last_save_position
