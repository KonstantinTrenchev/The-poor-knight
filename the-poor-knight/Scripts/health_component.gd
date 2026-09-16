class_name Health_Component
extends Node

signal dead
signal health_changed(new_amount)
@onready var invincibility_timer: Timer = $"../InvincibilityTimer"
@onready var animated_sprite: AnimatedSprite2D = $"../AnimatedSprite2D"
@export  var max_health := 3.0
@onready var hurtbox_component: Hurtbox_Component = $"../Hurtbox_Component"
var isInvincible
var current_health: float
func _ready() -> void:
	current_health = max_health
func _damage(attack:float) -> void:
	var temp_health: = current_health
	if invincibility_timer != null:
		if isInvincible:
			attack = 0
		else :
			invincibility_timer.start()
			isInvincible = true
	temp_health-=attack
	if temp_health!=current_health:
		current_health=temp_health
		if current_health<= 0:
			dead.emit()
			return
		print("Ouch. %s got hurt %.1d health left out of %d max health" %[get_parent().name,current_health, max_health])
		if invincibility_timer!=null:
			print("%s is now invincible for %.1f seconds" %[get_parent().name,invincibility_timer.wait_time])
	health_changed.emit(current_health)
	


func _on_invincibility_timer_timeout() -> void:
	isInvincible = false
	print("%s is now vulnerable" %get_parent().name)
