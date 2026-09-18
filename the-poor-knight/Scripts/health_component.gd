class_name Health_Component
extends Node
signal dead
signal health_changed(new_amount)
@onready var invincibility_timer: Timer = $"../InvincibilityTimer"
@onready var animated_sprite: AnimatedSprite2D = $"../AnimatedSprite2D"
@export  var max_health := 3.0
@onready var hurtbox_component: Hurtbox_Component = $"../Hurtbox"
var is_Invincible: bool
var is_hurt: bool
var current_health: float
func _ready() -> void:
	current_health = max_health
func _damage(attack:float) -> void:
	var temp_health: = current_health
	if invincibility_timer != null:
		if is_Invincible:
			attack = 0
		else :
			is_Invincible = true
	temp_health-=attack
	if temp_health!=current_health:
		is_hurt = true
		get_parent().speed = 0;
		current_health=temp_health
		if current_health<= 0:
			if animated_sprite.animation != "dead":
				animated_sprite.play("dead")
				await animated_sprite.animation_finished
			dead.emit()
			return
		if animated_sprite.animation != "hurt":
			animated_sprite.play("hurt")
			await animated_sprite.animation_finished
			is_hurt = false
			get_parent().speed = get_parent().default_speed
		print("Ouch. %s got hurt %.1d health left out of %d max health" %[get_parent().name,current_health, max_health])
		if invincibility_timer!=null:
			print("%s is now invincible for %.1f seconds" %[get_parent().name,invincibility_timer.wait_time])
			invincibility_timer.start()
	health_changed.emit(current_health)
	


func _on_invincibility_timer_timeout() -> void:
	is_Invincible = false
	print("%s is now vulnerable" %get_parent().name)
